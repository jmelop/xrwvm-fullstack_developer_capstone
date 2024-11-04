#!/bin/sh

# Make migrations and migrate the database.
echo "Making migrations and migrating the database. "
python manage.py makemigrations --noinput
python manage.py migrate --noinput

# Create superuser if it doesn't exist
if ! python manage.py shell -c "from django.contrib.auth.models import User; print(User.objects.filter(username='root').exists())"; then
    echo "Creating superuser."
    echo "from django.contrib.auth.models import User; User.objects.create_superuser('root', 'root@example.com', 'root')" | python manage.py shell
fi

python manage.py collectstatic --noinput
exec "$@"