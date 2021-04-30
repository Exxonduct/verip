#!/bin/bash

clear

x=0

while [ "$x" != "6" ]
do 
	
    echo ''
echo -e "	  ██╗██████╗ 
	  ██║██╔══██╗
	  ██║██████╔╝
	  ██║██╔═══╝ 
	  ██║██║     
	  ╚═╝╚═╝     
           "
    echo '♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢'
    echo "  Bienvenido al Script \"verip\" "
	echo '♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢♢'

    echo ""

    echo "Por favor seleccione una de estas opciones:
    
    1. Saber mi dirección IP privada
    2. Saber mi dirección IP pública
    3. Ver mi tabla Arp
    4. Enviar un ping
    5. Ver cuantos dispositivos hay en la red local (es posible que no salgan todos debido al firewall)
    6. Salir
    "
    
    echo -n "Introduce tu opción: "
    read x

    echo ''

    case $x in 

        1) 

            y=$(hostname -I)

			man ifconfig >/dev/null 2>/dev/null
			
			if [ $? -eq 0 ]
			then

				echo -e "Tu dirección IP privada es \e[32m$y\e[0m"

				echo ''
				
				echo -n "Presiona enter para continuar "
				read -s con
				
				clear
				continue

				
			else
			
				echo "Net-tools no está instalado en tu equipo, quieres instalarlo?"
				echo -n "Y para si,N para no: "
				read curl
				
				
				if [ "$curl" = "[Yy]" ]
				then
				
					sudo apt install net-tools
				
				elif [ "$curl" = "[Nn]" ]
				then
				
					echo "Saliendo..."
					sleep 1
					
					clear
					
				else
				
					echo "Ha habido un error al seleccionar la opción"
					sleep 1 
					
					clear
					
					continue
					
				fi
				
			fi
			
			
		;;
		
        2) 

            y=$(curl -s ifconfig.co)

        if [ $? -eq 0 ]
        then

            echo -e "Tu dirección IP pública es \e[32m $y \e[0m"

            echo ''
            
            echo -n "Presiona enter para continuar "
            read -s con
            
            clear

            continue

        else
			
			man curl 2>/dev/null >/dev/null
			
			if [ $? -eq 0 ]
			then
			
				echo "Ha habido un error consiguiendo su IP pública, está conectado a Internet?"
				sleep 1
				
				clear
			
			else
			
				echo "Curl no está instalado en tu equipo, quieres instalarlo?"
				echo -n "Y para si,N para no: "
				read curl
				
				
				
				if [ "$curl" = "Y" ]
				then
				
					sudo apt install curl
				
				elif [ "$curl" = "N" ]
				then
				
					echo "Saliendo..."
				
					sleep 1
					
					clear
					
					
				else
				
					echo "Ha habido un error al seleccionar la opción"
					sleep 1 
					
					clear
					
					continue
				fi
			fi
			
        fi
        
        ;;

        3)

            arp 
            echo " "

            echo -n "Presiona enter para continuar "

            read -s con

			clear
			
            continue

        ;;

        4)

            echo -n "Introduzca la dirección: "
            read y
            ping -a -c4 $y

			echo ""
		
            echo -n "Presiona enter para continuar "

            read -s con

			
            sleep 1
            
            clear
			
            continue

        ;;
        
        5)
        
			v=$(ifconfig | egrep 192.168.[0-255].[0-254] | cut -c 9- | cut -f2 -d' ' | cut -f3 -d'.')
			
			z=$(nmap -sP 192.168.$v.* | egrep "Nmap done" | cut -c 30- | cut -f1 -d' ')
			
			man nmap >/dev/null 2>/dev/null

			if [ $? -eq 0 ]
			then

				echo -e "En tu red hay al menos\e[32m $z\e[0m hosts"

				echo ''
				
				echo -n "Presiona enter para continuar "
				read -s con

				clear
				
				continue

			else
				
				nmap 2>/dev/null >/dev/null
				
				if [ $? -eq 0 ]
				then
				
					echo "Ha habido un error realizando el escaneo, está conectado a una red?"
					sleep 1
					
					clear
				
				else
				
					echo "Nmap no está instalado en tu equipo, quieres instalarlo?"
					echo -n "Y para si,N para no: "
					read curl
					
					clear
					
					if [ "$curl" = "Y" ]
					then
					
						sudo apt install nmap
					
					elif [ "$curl" = "N" ]
					then
					
						echo "Saliendo..."
						sleep 1
						
						clear
						
					else
					
						echo "Ha habido un error al seleccionar la opción"
						sleep 1 
						
						clear
						continue
					fi
				fi
				
			fi
			
			
		;;

        6) 

            echo "Saliendo..."
            sleep 0.7
            break

        ;;

        *)

            echo "Ha habido un error seleccionando la opción, por favor, inténtelo de nuevo."
            sleep 1 
            
            clear
            continue
        
        ;;

    esac

done
