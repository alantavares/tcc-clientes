<?php

declare(strict_types=1);

namespace App\Infrastructure\Consumer;

use codename\parquet\ParquetWriter;
use codename\parquet\data\Schema;
use codename\parquet\data\DataField;
use codename\parquet\data\DataColumn;

use Aws\S3\S3Client;
use Aws\Credentials\Credentials;

use Symfony\Component\Messenger\Handler\MessageHandlerInterface;

use App\Domain\Event\ClientCreated;

#[AsMessageHandler]
class ClientCreatedHandler implements MessageHandlerInterface
{
    private $s3Client;

    public function __invoke(ClientCreated $event) : void
    {
        $this->setS3Wrapper();
        $this->createClientFile($event);  
    }

    private function createClientFile($event)
    {
        $idColumn = new DataColumn(
            DataField::createFromType('id', 'string'),
            [ $event->getId() ]
        );
        
        $nameColumn = new DataColumn(
            DataField::createFromType('name', 'string'),
            [ $event->getName() ]
        );

        $emailColumn = new DataColumn(
            DataField::createFromType('email', 'string'),
            [  $event->getEmail() ]
        );

        $phoneColumn = new DataColumn(
            DataField::createFromType('phone', 'string'),
            [  $event->getPhone() ]
        );
        
        // create file schema
        $schema = new Schema([$idColumn->getField(), $nameColumn->getField(), $emailColumn->getField(), $phoneColumn->getField()]);

        // create file handle with w+ flag, to create a new file - if it doesn't exist yet - or truncate, if it exists
        $fileStream = fopen('s3://'.getenv('S3_BUCKET').'/client_'.$event->getId().'.parquet', 'w');
        // $fileStream = fopen(__DIR__.'/test.parquet', 'w+');

        $parquetWriter = new ParquetWriter($schema, $fileStream);

        // create a new row group in the file
        $groupWriter = $parquetWriter->CreateRowGroup();

        $groupWriter->WriteColumn($idColumn);
        $groupWriter->WriteColumn($nameColumn);
        $groupWriter->WriteColumn($emailColumn);
        $groupWriter->WriteColumn($phoneColumn);

        // As we have no 'using' in PHP, I implemented finish() methods
        // for ParquetWriter and ParquetRowGroupWriter

        $groupWriter->finish();   // finish inner writer(s)
        $parquetWriter->finish(); // finish the parquet writer last

        return $fileStream;
    }

    public function setS3Wrapper(): void
    {
        
        $options = [
            'region' => 'us-east-1',
            'version'=> '2006-03-01'
        ];
        $s3Endpoint = getenv('S3_ENDPOINT');
        if ($s3Endpoint){
            $credentials = new Credentials(null, null);
            $options['endpoint'] = $s3Endpoint;
            $options['credentials'] = $credentials;
        }        
        
        $this->s3Client = new S3Client($options);
        $this->s3Client->registerStreamWrapper();

        $this->createBucketIfNotExists();
        
    }

    private function createBucketIfNotExists()
    {
        if ($this->checkBucketExists() || getenv('APP_ENV') == 'prod') {
            return true;
        }

        try {
            $bucketName = getenv('S3_BUCKET');
            $result = $this->s3Client->createBucket([
                'Bucket' => $bucketName,
            ]);
            echo 'The bucket\'s location is: ' .
                $result['Location'] . '. ' .
                'The bucket\'s effective URI is: ' . 
                $result['@metadata']['effectiveUri'];
        } catch (AwsException $e) {
            echo 'Error: ' . $e->getAwsErrorMessage();
        }

    }

    private function checkBucketExists()
    {
        $buckets = $this->s3Client->listBuckets();
        $bucketName = getenv('S3_BUCKET');
        $exists = false;
        foreach ($buckets['Buckets'] as $bucket) {
            if ($bucket['Name'] == $bucketName){
                $exists = true;
                break;
            }
        }
        return $exists;
    }

}