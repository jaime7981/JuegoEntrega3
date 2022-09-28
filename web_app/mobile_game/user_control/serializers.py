from django.contrib.auth.models import User
from .models import Player, FriendRequests
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from django.contrib.auth.password_validation import validate_password

class MyTokenObtainPairSerializer(TokenObtainPairSerializer):
    @classmethod
    def get_token(cls, user):
        token = super(MyTokenObtainPairSerializer, cls).get_token(user)
        token['username'] = user.username
        return token

class RegisterSerializer(serializers.ModelSerializer):
    password1 = serializers.CharField(write_only=True, required=True, validators=[validate_password])
    password2 = serializers.CharField(write_only=True, required=True)

    class Meta:
        model = User
        fields = ['username', 'password1', 'password2']

    def validate(self, attrs):
        if attrs['password1'] != attrs['password2']:
            raise serializers.ValidationError({"password": "Password fields didn't match."})
        return attrs

    def create(self, validated_data, commit=True):
        user = User.objects.create(
            username=validated_data['username']
        )
        user.set_password(validated_data['password1'])
        user.save(commit=False)
        if commit:
            user.save()
            player = Player.objects.create(user = user)
        return player

class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = ['username', 'password', 'first_name', 'last_name', 'email']

class PlayerSerializer(serializers.HyperlinkedModelSerializer):
    user = UserSerializer()

    class Meta:
        model = Player
        fields = ['user', 'matches_won', 'matches_lost', 'best_score']

class FriendRequestsSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = FriendRequests
        fields = ['sender_player', 'reciever_player', 'acepted_request']
