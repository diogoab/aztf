variable "ingress-nginx" {
  description = "Ingress Nginx variables"
  type = object({
    chart_version = string
  })
}
