"""
Cars urls.
"""


from django.conf.urls import include, url
from django.contrib import admin

from cars import views


urlpatterns = [
    url(r'^$', views.cars),
    url(r'action/', views.action),
    url(r'add_vehicle/', views.add_to_inventory),
    url(r'getopt/', views.get_options),
    url(r'getveh/', views.get_vehicles),
    url(r'getwish/', views.get_wish_list),
    url(r'login/', views.login),
    url(r'markwish/', views.mark_wish),
    url(r'register/', views.register),
]
