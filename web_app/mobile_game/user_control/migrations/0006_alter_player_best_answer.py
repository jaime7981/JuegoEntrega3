# Generated by Django 4.1 on 2022-10-24 06:51

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('user_control', '0005_player_best_answer_player_creation_date_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='player',
            name='best_answer',
            field=models.CharField(default='No best answer yet', max_length=100),
        ),
    ]