from rest_framework import viewsets, permissions
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.authentication import SessionAuthentication, BasicAuthentication, TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.authtoken.models import Token
from rest_framework.permissions import AllowAny

from django.contrib.auth.models import User
from .serializers import PlayerSerializer, FriendRequestsSerializer, RegisterSerializer, SentFriendRequestSerializer, FriendRequestsUsernameSerializer, UserSerializer
from .models import Player, FriendRequests

import logging
logger = logging.getLogger('django')

class PermissionPolicyMixin:
    def check_permissions(self, request):
        try:
            handler = getattr(self, request.method.lower())
        except AttributeError:
            handler = None

        if (
            handler
            and self.permission_classes_per_method
            and self.permission_classes_per_method.get(handler.__name__)
        ):
            self.permission_classes = self.permission_classes_per_method.get(handler.__name__)
        super().check_permissions(request)

class UserViewSet(viewsets.ModelViewSet):
    authentication_classes = [] #disables authentication
    permission_classes = [AllowAny]

    queryset = User.objects.all()
    serializer_class = UserSerializer

    def create(self, request):
        serializer = RegisterSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
        return Response(serializer.data)
    
    @action(methods=['post'], detail=False)
    def get_user_info(self, request, *args, **kwargs):
        user = User.objects.get(username=request.data['username'])
        items = Player.objects.get(user=user.id)
        serializer = PlayerSerializer(items)
        return Response(serializer.data)

class PlayerViewSet(viewsets.ModelViewSet):
    authentication_classes = [] #disables authentication
    permission_classes = [AllowAny]

    queryset = Player.objects.all()
    serializer_class = PlayerSerializer

    def create(self, request):
        serializer = RegisterSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
        return Response(serializer.data)

    @action(methods=['get'], detail=False)
    def get_user_info(self, request, *args, **kwargs):
        items = Player.objects.get(user=request.user)
        serializer = PlayerSerializer(items)
        return Response(serializer.data)
    
    @action(methods=['post'], detail=False)
    def create_player(self, request, *args, **kwargs):
        logger.info(request.data)
        user = User.objects.create(
            username=request.data['username']
        )
        user.set_password(request.data['password1'])
        user.save()
        Player.objects.create(user=user)
        Token.objects.create(user=user)
        serializer = UserSerializer(user)
        return Response(serializer.data)

class FriendRequestsViewSet(viewsets.ModelViewSet):
    authentication_classes = [SessionAuthentication, BasicAuthentication, TokenAuthentication]
    permission_classes = [IsAuthenticated]

    queryset = FriendRequests.objects.all()
    serializer_class = FriendRequestsSerializer

    @action(methods=['get'], detail=False)
    def acepted(self, request, *args, **kwargs):
        acepted = FriendRequests.objects.filter(acepted_request=True)
        player = Player.objects.get(user=request.user)
        items = acepted.filter(sender_player=player) | acepted.filter(reciever_player=player)
        serializer = FriendRequestsUsernameSerializer(items, many=True)
        return Response(serializer.data)

    @action(methods=['get'], detail=False)
    def sent(self, request, *args, **kwargs):
        player = Player.objects.get(user=request.user)
        items = FriendRequests.objects.filter(acepted_request=False).filter(sender_player=player)
        serializer = FriendRequestsUsernameSerializer(items, many=True)
        return Response(serializer.data)
    
    @action(methods=['get'], detail=False)
    def recieved(self, request, *args, **kwargs):
        player = Player.objects.get(user=request.user)
        items = FriendRequests.objects.filter(acepted_request=False).filter(reciever_player=player)
        serializer = FriendRequestsUsernameSerializer(items, many=True)
        return Response(serializer.data)

    @action(methods=['post'], detail=False)
    def send_friend_request_by_username(self, request):
        serializer = SentFriendRequestSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
        return Response(serializer.data)
    
    @action(methods=['post'], detail=False)
    def create_player(self, request):
        logger.info(request.data)
        user = User.objects.create(
            username=request.data['username']
        )
        user.set_password(request.data['password1'])
        user.save()
        Player.objects.create(user=user)
        Token.objects.create(user=user)
        serializer = UserSerializer(user)
        return Response(serializer.data)

class PlayerViewSet(PermissionPolicyMixin, viewsets.ModelViewSet):
    authentication_classes = [SessionAuthentication, BasicAuthentication, TokenAuthentication]
    permission_classes = [IsAuthenticated]
    permission_classes_per_method = {
        "create": [permissions.AllowAny]
    }

    queryset = Player.objects.all()
    serializer_class = PlayerSerializer

    
