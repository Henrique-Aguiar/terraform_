terraform import aws_lb.meu_load_balancer arn:aws:elasticloadbalancing:us-east-1:285552379206:loadbalancer/app/meu-load-balancer/438f07fe9c98e081

terraform import aws_acm_certificate.dves_cloud arn:aws:acm:us-east-1:285552379206:certificate/ad4b3159-a9ee-4173-8c51-365614038e22

terraform import aws_lb_listener.meu_load_balancer arn:aws:elasticloadbalancing:us-east-1:285552379206:listener/app/meu-load-balancer/438f07fe9c98e081/d6d85fba9b575bfd
                                                   
terraform import aws_lb_target_group.meu_load_balancer arn:aws:elasticloadbalancing:us-east-1:285552379206:targetgroup/destino/f3f36099ac58f7ef

terraform import aws_vpc.default vpc-0b0665db5a711964d

terraform import aws_instance.web i-03c88e4a97bba62c3
terraform import aws_instance.mysql i-056c239727598c8be

terraform import aws_route53_zone.dves_cloud Z0806126MWG7ACV452UT
terraform import aws_route53_zone.dves_private Z0335618G2T7ZWCNKBQB

terraform import aws_route53_record.dves_cloud Z0806126MWG7ACV452UT_dves.cloud_A
terraform import aws_route53_record.henrique_dves_cloud Z0806126MWG7ACV452UT_henrique.dves.cloud_CNAME

 terraform import aws_route53_record.mysql_dves_private Z0335618G2T7ZWCNKBQB_mysql.dves.private_A
 terraform import aws_route53_record.server_dves_private Z0335618G2T7ZWCNKBQB_server.dves.private_A


terraform import aws_lb.vbncn arn:aws:elasticloadbalancing:us-east-1:285552379206:loadbalancer/net/vbncn/9ddfaaef9e7fd151
terraform import aws_lb_target_group.web2 arn:aws:elasticloadbalancing:us-east-1:285552379206:targetgroup/web2/7afb12f5b1349055
terraform import aws_lb_listener.vbncn arn:aws:elasticloadbalancing:us-east-1:285552379206:listener/net/vbncn/112555ea291c3e34/c0d65376c035802c
