# -*- coding: utf-8 -*-
# Generated by Django 1.10.1 on 2016-09-18 04:46
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='User',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('full_name', models.CharField(max_length=100)),
                ('email', models.EmailField(max_length=100)),
                ('password', models.CharField(max_length=15)),
                ('user_type', models.CharField(choices=[(b'admin', b'Admin'), (b'vadmin', b'Vehicle Admin'), (b'user', b'General User')], max_length=10)),
                ('approved', models.NullBooleanField(default=False)),
                ('registration_time', models.DateTimeField(null=True)),
                ('approved_time', models.DateTimeField(null=True)),
            ],
        ),
    ]
