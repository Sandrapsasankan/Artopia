# Generated by Django 4.2.1 on 2023-06-17 08:14

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ("Artista", "0018_complaint_status"),
    ]

    operations = [
        migrations.RemoveField(
            model_name="complaint",
            name="status",
        ),
    ]