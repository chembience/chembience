from django.contrib import admin
from django.urls import path, include

from . import views

urlpatterns = [
    path('resolver/<str:smiles>', views.resolver),
]
