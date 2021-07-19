

data "aws_vpc" "baseline" {

  filter {
       name = "isDefault"
       values = ["false"]
  }

  tags = {
      Name = "${var.network_namespace}-${var.network_stage}-${var.network_name}"
  }
}

data "aws_subnet_ids" "public_subnet_ids" {

  vpc_id = data.aws_vpc.baseline.id

  filter {
      name="tag:Name"
      values = [

        "${var.network_namespace}-${var.network_stage}-${var.network_name}-public-apse1a",
        "${var.network_namespace}-${var.network_stage}-${var.network_name}-public-apse1b",
        "${var.network_namespace}-${var.network_stage}-${var.network_name}-public-apse1c"
      ]
    }

}

data "aws_subnet_ids" "private_subnet_ids" {

  vpc_id = data.aws_vpc.baseline.id

  filter {
      name="tag:Name"
      values = [

        "${var.network_namespace}-${var.network_stage}-${var.network_name}-private-apse1a",
        "${var.network_namespace}-${var.network_stage}-${var.network_name}-private-apse1b",
        "${var.network_namespace}-${var.network_stage}-${var.network_name}-private-apse1c"
      ]
    }

}
