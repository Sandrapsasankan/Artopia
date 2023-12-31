# Generated by Django 4.2.1 on 2023-05-25 05:05

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = []

    operations = [
        migrations.CreateModel(
            name="artist",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("name", models.CharField(max_length=100)),
                ("address", models.CharField(max_length=100)),
                ("place", models.CharField(max_length=100)),
                ("phone_number", models.CharField(max_length=100)),
                ("email", models.EmailField(max_length=100)),
                ("role", models.CharField(max_length=100)),
                ("artiststatus", models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name="category",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("name", models.CharField(max_length=100)),
                ("image", models.ImageField(upload_to="images")),
                ("category_status", models.CharField(max_length=20)),
            ],
        ),
        migrations.CreateModel(
            name="job",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("jobname", models.CharField(max_length=20)),
                ("description", models.CharField(max_length=20)),
                ("location", models.CharField(max_length=20)),
                ("experience", models.CharField(max_length=20)),
                ("qualification", models.CharField(max_length=20)),
                ("salary", models.CharField(max_length=20)),
                ("status", models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name="login",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("username", models.CharField(max_length=100, unique=True)),
                ("password", models.CharField(max_length=100, unique=True)),
                ("role", models.CharField(max_length=10)),
            ],
        ),
        migrations.CreateModel(
            name="user",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("name", models.CharField(max_length=100)),
                ("address", models.CharField(max_length=100)),
                ("place", models.CharField(max_length=100)),
                ("phone_number", models.CharField(max_length=100)),
                ("email", models.EmailField(max_length=100)),
                ("role", models.CharField(max_length=20)),
                ("userstatus", models.CharField(max_length=20)),
                (
                    "login_id",
                    models.OneToOneField(
                        on_delete=django.db.models.deletion.CASCADE, to="Artista.login"
                    ),
                ),
            ],
        ),
        migrations.CreateModel(
            name="product",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("name", models.CharField(max_length=100)),
                ("description", models.CharField(max_length=100)),
                ("amount", models.CharField(max_length=100)),
                ("image", models.ImageField(upload_to="images")),
                ("dimension", models.CharField(max_length=100)),
                ("colour", models.CharField(max_length=100)),
                ("product_status", models.CharField(max_length=20)),
                (
                    "artist",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE, to="Artista.artist"
                    ),
                ),
                (
                    "category",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        to="Artista.category",
                    ),
                ),
            ],
        ),
        migrations.AddField(
            model_name="artist",
            name="login_id",
            field=models.OneToOneField(
                on_delete=django.db.models.deletion.CASCADE, to="Artista.login"
            ),
        ),
    ]
