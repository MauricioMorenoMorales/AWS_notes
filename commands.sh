# Ve al inicio
cd

# Crea varios directorios nesteados
mkdir -p /india/mumbai

# Te ayudan a navegar en ciertas direcciones, como si fuera un navegador
pushd
popd

# Mover un directorio
mv $SOURCE_FILE $TARGET_DIRECTORY

# Cambiar nombre a un archivo
mv $SOURCE_DIRECTORY $TARGET_DIRECTORY

# Copiar archivo
cp $SOURCE_FILE $TARGET_DIRECTORY

# ELiminar un archivo o directorio
rm $FILE

# Eliminar directorio
rm -r $DIRECTIRY

# Imprimir informacion de un archivo
cat $FILE

cat > $FILE

# Te permiten manejar en un archivo, pero son mejor vim
more $FILE
less $FILE

# Muestra todos los archivos incluyendo los escondidos
ls -a

#! Maneras de tener ayuda mientras usas una shell

# The ayuda a saber rapidamente que hace un comando
whatis date
man date
date --help
modpr