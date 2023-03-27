# =================
# Compute Resources
# =================

# https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/data-sources/datasource_compute_image

data "yandex_compute_image" "vm_image" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "vm-1" {
  name = "terraform1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      #image_id = "fd83klic6c8gfgi40urb"
      image_id = data.yandex_compute_image.vm_image.id
      #image_id = "${data.yandex_compute_image.vm_image.id}"
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

/*
resource "yandex_compute_instance" "vm-2" {
  name = "terraform2"

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "${data.yandex_compute_image.vm_image.id}"
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
*/