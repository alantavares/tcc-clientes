locals {
    env = {
        default = {
            desired_tasks                                  = 1
            desired_task_cpu                               = "512"
            desired_task_memory                            = "1024"
            desired_app_task_cpu                           = "256" 
            desired_app_task_memory                        = "512"
            min_tasks                                      = 1
            max_tasks                                      = 1
            cpu_to_scale_up                                = 80
            cpu_to_scale_down                              = 30
            memory_to_scale_up                             = 80
            memory_to_scale_down                           = 10
        }
        prod  = {
            desired_tasks                                  = 1
            desired_task_cpu                               = "512"
            desired_task_memory                            = "1024"
            desired_app_task_cpu                           = "256" 
            desired_app_task_memory                        = "512"
            min_tasks                                      = 1
            max_tasks                                      = 1
            cpu_to_scale_up                                = 80
            cpu_to_scale_down                              = 30
            memory_to_scale_up                             = 80
            memory_to_scale_down                           = 10
        }
    }

    environmentvars = contains(keys(local.env), terraform.workspace) ? terraform.workspace : "default"
    workspace       = merge(local.env["default"], local.env[local.environmentvars])
}