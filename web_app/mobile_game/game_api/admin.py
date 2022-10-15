from django.contrib import admin
from .models import Game, Lobby, Question, Round, Answer

# Register your models here.
admin.site.register(Game)
admin.site.register(Lobby)
admin.site.register(Question)
admin.site.register(Round)
admin.site.register(Answer)
