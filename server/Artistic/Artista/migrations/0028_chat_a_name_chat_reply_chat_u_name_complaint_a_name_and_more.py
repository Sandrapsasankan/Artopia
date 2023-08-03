# Generated by Django 4.2.1 on 2023-07-15 05:07

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ("Artista", "0027_cart_expday_order_expday_product_expday"),
    ]

    operations = [
        migrations.AddField(
            model_name="chat",
            name="a_name",
            field=models.CharField(default=1, max_length=500),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name="chat",
            name="reply",
            field=models.CharField(default="no reply", max_length=500),
        ),
        migrations.AddField(
            model_name="chat",
            name="u_name",
            field=models.CharField(default=1, max_length=500),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name="complaint",
            name="a_name",
            field=models.CharField(default=1, max_length=500),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name="complaint",
            name="artist",
            field=models.ForeignKey(
                default=1,
                on_delete=django.db.models.deletion.CASCADE,
                to="Artista.artist",
            ),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name="complaint",
            name="reply",
            field=models.CharField(default="no reply", max_length=500),
        ),
        migrations.AddField(
            model_name="complaint",
            name="u_name",
            field=models.CharField(default=1, max_length=500),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name="feedback",
            name="name",
            field=models.CharField(default=1, max_length=20),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name="order",
            name="artist",
            field=models.ForeignKey(
                default=1,
                on_delete=django.db.models.deletion.CASCADE,
                to="Artista.artist",
            ),
            preserve_default=False,
        ),
    ]