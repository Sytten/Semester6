import sys
import csv

def main():
    try:
        file_name = sys.argv[1]
    except:
        print("Must specify a file name")
        sys.exit(-1)

    with open('insert_script.sql', 'w') as script_file:
        script_file.write("INSERT INTO locaux(numeropavillon, numero, pavillonparent, localparent, categorieid, capacite, note) VALUES\n")

        caracteristiques = []

        # Insertion des locaux
        with open(file_name) as csv_file:
            reader = csv.reader(csv_file, delimiter=',')
            first = True
            for row in reader:
                pavillon, numero_local, *numero_sous_local = row[0].split("-")

                capacite = row[1]
                categorie = row[2]
                note = row[4]
                pavillon_parent = 'null'
                local_parent = 'null'

                if len(numero_sous_local) > 0:
                    pavillon_parent = "'{0}'".format(pavillon)
                    local_parent = numero_local
                    numero_local = numero_sous_local[0]

                caracteristiques.append((numero_local, pavillon, row[3].split("|")))

                if first:
                    script_file.write(" ")
                else:
                    script_file.write(",")

                script_file.write("('{0}',{1},{2},{3},{4},{5},'{6}')\n".format(pavillon, numero_local, pavillon_parent, local_parent, categorie, capacite, note))
                first = False

            script_file.write(";\n")

        # Insertion des caracteristiques
        script_file.write("INSERT INTO caracteristiquelocal(equipementid, numeropavillon, numero) VALUES\n")
        first = True
        for local_caracteristiques in caracteristiques:
            for caracteristique in local_caracteristiques[2]:
                if caracteristique == "":
                    continue

                if first:
                    script_file.write(" ")
                else:
                    script_file.write(",")

                script_file.write("({0},'{1}',{2})\n".format(caracteristique, local_caracteristiques[1], local_caracteristiques[0]))
                first = False

        script_file.write(";\n")

if __name__ == "__main__":
    main()
