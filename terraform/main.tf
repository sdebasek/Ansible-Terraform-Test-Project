module "webservers" {
    source = "./webservers"
    ec2-sg = [module.securitygroups.ssh_security_group_id, module.securitygroups.http_security_group_id]
    key-pair = var.key-pair
    no_of_vms = var.number_of_webservers
    subnets = module.securitygroups.subnets
    tg_arn = module.loadbalancers.tg_arn
}

module "dbservers" {
    source = "./dbservers"
    ec2-sg = [module.securitygroups.ssh_security_group_id, module.securitygroups.mysql_security_group_id]
    key-pair = var.key-pair
    subnets = module.securitygroups.subnets
}


module "securitygroups" {
    source = "./security-groups"
    webserver_ips = module.webservers.private_ip
}

module "loadbalancers" {
    source = "./loadbalancers"
    vpc-name = module.securitygroups.vpc_name
    subnets = module.securitygroups.subnets
    ec2-sg = [module.securitygroups.http_security_group_id]
}