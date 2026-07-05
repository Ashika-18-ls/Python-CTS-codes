from django.http import HttpResponse
from rest_framework import viewsets
from .models import Course
from .serializers import CourseSerializer


def hello_view(request):
    return HttpResponse("Course Management API is running")


class CourseViewSet(viewsets.ModelViewSet):
    queryset = Course.objects.all()
    serializer_class = CourseSerializer