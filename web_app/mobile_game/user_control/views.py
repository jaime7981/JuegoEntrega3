from rest_framework import viewsets, permissions
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.authentication import SessionAuthentication, BasicAuthentication, TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from django.contrib.auth.models import User
from rest_framework.authtoken.models import Token
from .serializers import PlayerSerializer, FriendRequestsSerializer, RegisterSerializer, TokenSerializer
from .models import Player, FriendRequests

class LoginViewSet(viewsets.ModelViewSet):
    queryset = Token.objects.all()
    serializer_class = TokenSerializer
    authentication_classes = [SessionAuthentication, BasicAuthentication, TokenAuthentication]
    permission_classes = [IsAuthenticated]

class PlayerViewSet(viewsets.ModelViewSet):
    queryset = Player.objects.all()
    serializer_class = PlayerSerializer
    permission_classes = [permissions.AllowAny]

    def create(self, request):
        serializer = RegisterSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
        return Response(serializer.data)

    @action(methods=['get'], detail=True)
    def first_player(self, request, *args, **kwargs):
        items = Player.objects.get(user = User.objects.get(pk=1))
        serializer = PlayerSerializer(items)
        return Response(serializer.data)

class FriendRequestsViewSet(viewsets.ModelViewSet):
    permission_classes = [permissions.AllowAny]

    queryset = FriendRequests.objects.all()
    serializer_class = FriendRequestsSerializer
