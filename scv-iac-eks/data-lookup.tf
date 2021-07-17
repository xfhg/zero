



data "aws_vpc" "scv-development-zero" {
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

        "${var.network_namespace}-${var.network_stage}-${var.network_name}-public-use1a",
        "${var.network_namespace}-${var.network_stage}-${var.network_name}-public-use1b",
        "${var.network_namespace}-${var.network_stage}-${var.network_name}-public-use1c"
      ]
    }

}

data "aws_subnet_ids" "private_subnet_ids" {

  vpc_id = data.aws_vpc.baseline.id

  filter {
      name="tag:Name"
      values = [

        "${var.network_namespace}-${var.network_stage}-${var.network_name}-private-use1a",
        "${var.network_namespace}-${var.network_stage}-${var.network_name}-private-use1b",
        "${var.network_namespace}-${var.network_stage}-${var.network_name}-private-use1c"
      ]
    }

}
