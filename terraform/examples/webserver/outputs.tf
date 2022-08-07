output "webserver_external_ip" {
  value = module.webserver.webserver_external_ip[0]
}

output "webserver_internal_ip" {
  value = module.webserver.webserver_internal_ip[0]
}

output "url" {
  value = module.webserver.url
}
