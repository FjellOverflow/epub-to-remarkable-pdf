>[!CAUTION]
>Use these scripts at your own risk. I am not responsible for any damage to your device. Please always check the script contents yourself before running them.

# epub-to-remarkable-pdf

Simple scripts for converting eBooks (`.epub` files) into `.pdf` files, optimized for the reMarkable 2 eInk tablet, and uploading them to the device.

There are two versions of the conversion script. The default `convert.sh` converts the file locally on the system, while `convert-docker.sh` converts the file in a temporary Docker container.

>[!TIP]
>If you do not want to install extra dependencies on your system, run the Docker version of the script.

## *Recommended:* Convert `.epub` to `.pdf` (Docker)

>[!NOTE]
>To use the containerized script, you need [Docker](https://docs.docker.com/get-started/get-docker/) installed on your system.

Simply copy the following command to your terminal and adjust the file path.

```bash
curl -fsSL https://epub-to-remarkable-pdf.fjelloverflow.dev/convert-docker.sh | bash -s /path/to/your/file.epub
```

## Convert `.epub` to `.pdf` (Local)

>[!NOTE]
>To use the local script, you need [Calibre](https://calibre-ebook.com/) and the `Georgia` font installed on your system.

Simply copy the following command to your terminal and adjust the file path.

```bash
curl -fsSL https://epub-to-remarkable-pdf.fjelloverflow.dev/convert.sh | bash -s /path/to/your/file.epub
```

## Upload file to reMarkable Device

>[!NOTE]
>Make sure your tablet is plugged into your computer via USB and that the WEB-UI is enabled in the settings and accessible at http://10.11.99.1 in your browser.

Copy the following command to your terminal and adjust the file path.

```bash
curl -fsSL https://epub-to-remarkable-pdf.fjelloverflow.dev/upload.sh | bash -s /path/to/your/file.pdf
```
