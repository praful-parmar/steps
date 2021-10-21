
//download images
resource "docker_image" "container_image" { //first is provide name and second is alias for call it
  name = var.image_in                       //name of the image ( docker hub image )
}