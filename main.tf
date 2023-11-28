resource "google_compute_instance" "dare-id-vm" {
  name         = "dareit-vm-tf"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

 tags = ["dareit"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        managed_by_terraform = "true"
      }
    }
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y apache2
    systemctl start apache2
    systemctl enable apache2
    echo "<html><head>
    <meta charset='UTF-8'>
    <title>My static website</title>
    <link rel='stylesheet' href='style.css'>
</head>
<body>
    <header style='text-align: center;'>
        <h1>Albert Einstein quote</h1>
    </header>
    
    <main style='text-align: center;'>
        <p style='font-size: 20px;'>
            Imagination is more important than knowledge.<br>
             For knowledge is limited, whereas imagination embraces the entire world,<br>
              stimulating progress, giving birth to evolution.
        </p>
        <img src='https://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Albert_Einstein_Head.jpg/1536px-Albert_Einstein_Head.jpg' alt='Albert_einstein' width='200' height='200'>
    </main>
    
</body></html>" > /var/www/html/index.html
  EOF

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
}
