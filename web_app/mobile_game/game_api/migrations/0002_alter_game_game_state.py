# Generated by Django 4.1 on 2022-10-14 19:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('game_api', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='game',
            name='game_state',
            field=models.CharField(choices=[('W', 'Writing'), ('A', 'Answering'), ('S', 'Starting')], max_length=1),
        ),
    ]
