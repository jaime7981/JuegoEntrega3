from django.urls import path
from . import views as usercontrol
from django.views.generic import RedirectView

urlpatterns = [
    path('', RedirectView.as_view(url='/usercontrol/login')),
    path('login', usercontrol.login, name = 'login'),
    path('registration', usercontrol.registration, name = 'registration'),
    path('logout', usercontrol.logout, name = 'logout'),
]