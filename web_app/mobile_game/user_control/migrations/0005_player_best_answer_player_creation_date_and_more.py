# Generated by Django 4.1 on 2022-10-24 06:47

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('user_control', '0004_alter_player_user'),
    ]

    operations = [
        migrations.AddField(
            model_name='player',
            name='best_answer',
            field=models.CharField(default=django.utils.timezone.now, max_length=100),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='player',
            name='creation_date',
            field=models.DateField(default=django.utils.timezone.now),
        ),
        migrations.AddField(
            model_name='player',
            name='current_date',
            field=models.DateField(default=django.utils.timezone.now),
        ),
        migrations.AddField(
            model_name='player',
            name='friends_amount',
            field=models.IntegerField(blank=True, default=0, null=True),
        ),
        migrations.AddField(
            model_name='player',
            name='group_playing',
            field=models.CharField(default='Yo literalmente no sé jugar', max_length=100),
        ),
        migrations.AddField(
            model_name='player',
            name='invites_made',
            field=models.IntegerField(blank=True, default=0, null=True),
        ),
        migrations.AddField(
            model_name='player',
            name='many_friends',
            field=models.CharField(default='No tengo amigos', max_length=100),
        ),
        migrations.AddField(
            model_name='player',
            name='match_percentage',
            field=models.IntegerField(blank=True, default=0, null=True),
        ),
        migrations.AddField(
            model_name='player',
            name='played_rounds',
            field=models.IntegerField(blank=True, default=0, null=True),
        ),
        migrations.AddField(
            model_name='player',
            name='round_percentage',
            field=models.IntegerField(blank=True, default=0, null=True),
        ),
        migrations.AddField(
            model_name='player',
            name='total_matches',
            field=models.IntegerField(blank=True, default=0, null=True),
        ),
        migrations.AddField(
            model_name='player',
            name='won_rounds',
            field=models.IntegerField(blank=True, default=0, null=True),
        ),
    ]
