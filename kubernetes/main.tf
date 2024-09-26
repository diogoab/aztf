module "ingress-nginx" {
  source = "./modules/ingress-nginx"

  chart_version = var.ingress-nginx.chart_version
}
