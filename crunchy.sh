#!/bin/bash

# This argument sets a premium username Crunchyroll account.
# By command line, it is "-u username" or "--username username"
USERNAME="" # Default: "" (Means guest session).

# This argument sets a password for your username Crunchyroll account.
# By command line, it is "-p password" or "--password password"
PASSWORD="" # Default: "" (Means guest session if username is not specific).

# This argument sets video resolution.
# By command line, it is "-r value" or "--resolution value".
# Default: "" (Means best resolution).
# Change to other value as "worst", "240p", "360p", "480p", "720p", "1080p", "best".
RESOLUTION="1080p"

# This argument sets the episodes to download.
# By command line, it is "-e <s>" or "--episodes <s>"
EPISODES="" # Default: "" (Means all).

# This argument sets subtitle format.
# By command line, it is "-f value" or "--format value".
# Default: "" (Means ass format).
FORMAT="ass"

# This argument sets output path.
# By command line, it is "-o value" or "--output value".
# Default: "" (Means same directory).
OUTPUT=""

# This argument sets Batch file.
# By command line, it is "-b value" or "--batch value".
# Default: "" (default: CrunchyRoll.txt).
BATCH=""

# CHECKING...
if [ ${#} -eq 0 ]
then
    	echo "Error. Crunchy needs a input URL as parameter."
        echo "Syntaxis:"
        echo "  ${0} -i URL [-f format] [-s force] [-c] [-o output]"
        exit -1
fi

# PARSING...
while [ ${#} -gt 0 ]
do
  	case "${1}" in
                -i|--input)
                        INPUT="${2}"
                        shift
                ;;
                -o|--output)
                        if [ "${2:0:1}" = "/" ]
                        then
                            	OUTPUT="${2}"
                        else
                            	OUTPUT="${DEST_DIR}/${2}"
                        fi
                        if [ -z "$(echo ${OUTPUT##*/} | grep "\.")" ] # Output given is a directory.
                        then
                            	DEST_DIR="$(readlink -f "${OUTPUT}")"
                                unset OUTPUT
                        fi
                        shift
                ;;
                -u|--username)
                        USERNAME="${2}"
                        shift
                ;;
                -p|--password)
                        PASSWORD="${2}"
                        shift
                ;;

                -e|--episodes)
                        EPISODES="${2}"
                        shift
                ;;

                -f|--format)
                        FORMAT="${2}"
                        shift
                ;;

                -b|--batch)
                        BATCH="${2}"
                        shift
                ;;

                -r|--resolution)
                        RESOLUTION="${2}"
                        shift
                ;;

                *)
                  	echo "Error. Unexpected argument: ${1}"
                        exit -1
                ;;
        esac
	shift
done

# PREPARING PARAMETERS
if [ -n "${USERNAME}" ]
then
    	USERNAME="-u ${USERNAME}"
fi
if [ -n "${PASSWORD}" ]
then
    	PASSWORD="-p ${PASSWORD}"
fi
if [ -n "${RESOLUTION}" ]
then
    	RESOLUTION="-r ${RESOLUTION}"
else
    	RESOLUTION="-r 1080p"
fi
if [ -n "${EPISODES}" ]
then
    	EPISODES="-e ${EPISODES}"
fi
if [ -n "${FORMAT}" ]
then
    	FORMAT="-f ${FORMAT}"
else
    	FORMAT="-f ass"
fi
if [ -n "${OUTPUT}" ]
then
    	OUTPUT="-o ${OUTPUT}"
else
    	OUTPUT="-o /downloads"
fi
if [ -n "${BATCH}" ]
then
    	BATCH="-b ${BATCH}"
fi
if [ -n "${INPUT}" ]
then
    	INPUT="-i ${INPUT}"
fi

# MAIN...


if [ -n "${BATCH}" ]
then
        crunchy ${USERNAME} ${PASSWORD} ${BATCH} ${OUTPUT} ${RESOLUTION} ${FORMAT}
else
    	if [ -n "${EPISODES}" ]
	then
                crunchy ${USERNAME} ${PASSWORD} ${INPUT} ${EPISODES} ${OUTPUT} ${RESOLUTION} ${FORMAT}
        else
                crunchy ${USERNAME} ${PASSWORD} ${INPUT} ${OUTPUT} ${RESOLUTION} ${FORMAT}
        fi
fi


