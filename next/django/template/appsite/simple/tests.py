import logging

from django.test import TestCase
from django.utils import timezone

from .models import Simple

logger = logging.getLogger('cirx')


class SimpleTests(TestCase):

    def test_simple(self):
        s = Simple(text="Hello", pub_date=timezone.now())
        s.save()
        logger.info(">>>> %s", s.id)
        self.assertTrue(True)
