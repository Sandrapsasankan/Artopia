# Generated by Django 4.2.1 on 2023-05-25 09:08

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ("Artista", "0005_alter_event_description"),
    ]

    operations = [
        migrations.RenameField(
            model_name="event",
            old_name="data",
            new_name="date",
        ),
    ]
