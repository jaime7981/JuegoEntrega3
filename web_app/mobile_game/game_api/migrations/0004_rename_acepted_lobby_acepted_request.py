# Generated by Django 4.1 on 2022-10-15 05:32

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('game_api', '0003_game_name_lobby_acepted_alter_round_round_state'),
    ]

    operations = [
        migrations.RenameField(
            model_name='lobby',
            old_name='acepted',
            new_name='acepted_request',
        ),
    ]
