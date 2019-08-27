################################### Logging ####################################

## Logging configuration as json
## Defaults to: None
THUMBOR_LOG_CONFIG = {{ THUMBOR_LOG_CONFIG | default(None) }}

## Log Format to be used by thumbor when writing log messages.
## Defaults to: %(asctime)s %(name)s:%(levelname)s %(message)s
THUMBOR_LOG_FORMAT = '{{ THUMBOR_LOG_FORMAT | default('%(asctime)s %(name)s:%(levelname)s %(message)s') }}'

## Date Format to be used by thumbor when writing log messages.
## Defaults to: %Y-%m-%d %H:%M:%S
THUMBOR_LOG_DATE_FORMAT = '{{ THUMBOR_LOG_DATE_FORMAT | default('%Y-%m-%d %H:%M:%S') }}'

################################################################################


################################### Imaging ####################################

## Max width in pixels for images read or generated by thumbor
## Defaults to: 0
MAX_WIDTH = {{ MAX_WIDTH | default(0) }}

## Max height in pixels for images read or generated by thumbor
## Defaults to: 0
MAX_HEIGHT = {{ MAX_HEIGHT | default(0) }}

## Max pixel count for images read by thumbor. Set to prevent decompression bomb DOS attack.
## Defaults to: 75000000 pixels
MAX_PIXELS = {{ MAX_PIXELS | default(75000000) }}

## Min width in pixels for images read or generated by thumbor
## Defaults to: 1
MIN_WIDTH = {{ MIN_WIDTH | default(1) }}

## Min width in pixels for images read or generated by thumbor
## Defaults to: 1
MIN_HEIGHT = {{ MIN_HEIGHT | default(1) }}

## Allowed domains for the http loader to download. These are regular
## expressions.
## Defaults to: []
ALLOWED_SOURCES =  {{ ALLOWED_SOURCES | default([]) }}


## Quality index used for generated JPEG images
## Defaults to: 80
QUALITY = {{ QUALITY | default(80) }}

## Exports JPEG images with the progressive flag set.
## Defaults to: True
PROGRESSIVE_JPEG = {{ PROGRESSIVE_JPEG | default(True) }}

## Specify subsampling behavior for Pillow (see `subsampling`               in
## http://pillow.readthedocs.org/en/latest/handbook/image-file-
## formats.html#jpeg).Be careful to use int for 0,1,2 and string for "4:4:4"
## notation. Will ignore `quality`. Using `keep` will copy the original file's
## subsampling.
## Defaults to: None
PILLOW_JPEG_SUBSAMPLING = {{ PILLOW_JPEG_SUBSAMPLING | default(None) }}

## Specify quantization tables for Pillow (see `qtables`               in
## http://pillow.readthedocs.org/en/latest/handbook/image-file-
## formats.html#jpeg). Will ignore `quality`. Using `keep` will copy the
## original file's qtables.
## Defaults to: None
PILLOW_JPEG_QTABLES = {{ PILLOW_JPEG_QTABLES | default(None) }}

## Specify resampling filter for Pillow resize method.One of LANCZOS, NEAREST,
## BILINEAR, BICUBIC, HAMMING (Pillow>=3.4.0).
## Defaults to: 'LANCZOS'
PILLOW_RESAMPLING_FILTER = '{{ PILLOW_RESAMPLING_FILTER | default('LANCZOS') }}'

## Quality index used for generated WebP images. If not set (None) the same level
## of JPEG quality will be used.
## Defaults to: None
WEBP_QUALITY = {{ WEBP_QUALITY | default(None) }}


## Compression level for generated PNG images.
## Defaults to: 6
PNG_COMPRESSION_LEVEL = {{ PNG_COMPRESSION_LEVEL | default(6) }}

## Specifies whether WebP format should be used automatically if the request
## accepts it (via Accept header)
## Defaults to: False
AUTO_WEBP = {{ AUTO_WEBP | default(False) }}

## Specifies whether non-transparent PNG images should be automatically converted to JPEG
## Defaults to: False
AUTO_PNG_TO_JPG = {{ AUTO_PNG_TO_JPG | default(False) }}

## Specify the ratio between 1in and 1px for SVG images. This is only used
## whenrasterizing SVG images having their size units in cm or inches.
## Defaults to: 150
SVG_DPI = {{ SVG_DPI | default(150) }}

## Max AGE sent as a header for the image served by thumbor in seconds
## Defaults to: 86400
MAX_AGE = {{ MAX_AGE | default(86400) }}

## Indicates the Max AGE header in seconds for temporary images (images with
## failed smart detection)
## Defaults to: 0
MAX_AGE_TEMP_IMAGE = {{ MAX_AGE_TEMP_IMAGE | default(0) }}

## Indicates whether thumbor should rotate images that have an Orientation EXIF
## header
## Defaults to: False
RESPECT_ORIENTATION = {{ RESPECT_ORIENTATION | default(False) }}

## Ignore errors during smart detections and return image as a temp image (not
## saved in result storage and with MAX_AGE_TEMP_IMAGE age)
## Defaults to: False
IGNORE_SMART_ERRORS = {{ IGNORE_SMART_ERRORS | default(False) }}

## Sends If-Modified-Since & Last-Modified headers; requires support from result
## storage
## Defaults to: False
SEND_IF_MODIFIED_LAST_MODIFIED_HEADERS = {{ SEND_IF_MODIFIED_LAST_MODIFIED_HEADERS | default(False) }}

## Preserves exif information in generated images. Increases image size in
## kbytes, use with caution.
## Defaults to: False
PRESERVE_EXIF_INFO = {{ PRESERVE_EXIF_INFO | default(False) }}

## Indicates whether thumbor should enable the EXPERIMENTAL support for animated
## gifs.
## Defaults to: True
ALLOW_ANIMATED_GIFS = {{ ALLOW_ANIMATED_GIFS | default(True) }}

## Indicates whether thumbor should use gifsicle engine. Please note that smart
## cropping and filters are not supported for gifs using gifsicle (but won't
## give an error).
## Defaults to: False
USE_GIFSICLE_ENGINE = {{ USE_GIFSICLE_ENGINE | default(False) }}

## Indicates whether thumbor should enable blacklist functionality to prevent
## processing certain images.
## Defaults to: False
USE_BLACKLIST = {{ USE_BLACKLIST | default(False) }}

## Size of the thread pool used for image transformations.  The default value is
## 0 (don't use a threadpoool. Increase this if you are seeing your IOLoop
## getting blocked (often indicated by your upstream HTTP requests timing out)
## Defaults to: 0
ENGINE_THREADPOOL_SIZE = {{ ENGINE_THREADPOOL_SIZE | default(0) }}



################################################################################


################################ Extensibility #################################

## The metrics backend thumbor should use to measure internal actions. This must
## be the full name of a python module (python must be able to import it)
## Defaults to: 'thumbor.metrics.logger_metrics'
METRICS = '{{ METRICS | default('thumbor.metrics.logger_metrics') }}'

## The loader thumbor should use to load the original image. This must be the
## full name of a python module (python must be able to import it)
## Defaults to: thumbor.loaders.http_loader
LOADER = '{{ LOADER | default('thumbor.loaders.http_loader') }}'

## The file storage thumbor should use to store original images. This must be the
## full name of a python module (python must be able to import it)
## Defaults to: thumbor.storages.file_storage
STORAGE = '{{ STORAGE | default('thumbor.storages.file_storage') }}'
STORAGE_BUCKET = '{{ STORAGE_BUCKET | default('') }}'
RESULT_STORAGE_BUCKET = '{{ RESULT_STORAGE_BUCKET | default('') }}'


## The result storage thumbor should use to store generated images. This must be
## the full name of a python module (python must be able to import it)
## Defaults to: None

RESULT_STORAGE = '{{ RESULT_STORAGE | default('thumbor.result_storages.file_storage') }}'


## The imaging engine thumbor should use to perform image operations. This must
## be the full name of a python module (python must be able to import it)
## Defaults to: thumbor.engines.pil
ENGINE = '{{ ENGINE | default('thumbor.engines.pil') }}'

## The gif engine thumbor should use to perform image operations. This must be
## the full name of a python module (python must be able to import it)
## Defaults to: 'thumbor.engines.gif'
GIF_ENGINE = '{{ GIF_ENGINE | default('thumbor.engines.gif') }}'

## The url signer thumbor should use to verify url signatures.This must be the
## full name of a python module (python must be able to import it)
## Defaults to: 'libthumbor.url_signers.base64_hmac_sha1'
URL_SIGNER = '{{ URL_SIGNER | default('libthumbor.url_signers.base64_hmac_sha1') }}'

################################################################################


################################### Security ###################################

## The security key thumbor uses to sign image URLs
## Defaults to: MY_SECURE_KEY
SECURITY_KEY = '{{ SECURITY_KEY | default('MY_SECURE_KEY') }}'

## Indicates if the /unsafe URL should be available
## Defaults to: True
ALLOW_UNSAFE_URL = {{ ALLOW_UNSAFE_URL | default(True) }}

## Indicates if encrypted (old style) URLs should be allowed
## Defaults to: True
ALLOW_OLD_URLS = {{ ALLOW_OLD_URLS | default(True) }}

## AWS access keys - used in thumbor_aws storage
AWS_ACCESS_KEY = '{{ AWS_ACCESS_KEY_ID | default('') }}'
AWS_SECRET_KEY = '{{ AWS_SECRET_ACCESS_KEY | default('') }}'

################################################################################

##################################### HTTP #####################################

## Enables automatically generated etags
## Defaults to: True
ENABLE_ETAGS = {{ ENABLE_ETAGS | default(True) }}

################################################################################


################################### Storage ####################################

## Set maximum id length for images when stored
## Defaults to: 32
MAX_ID_LENGTH = {{ MAX_ID_LENGTH | default(32) }}

################################################################################


{% if HEALTHCHECK_ROUTE is defined %}
HEALTHCHECK_ROUTE = '{{ HEALTHCHECK_ROUTE }}'
{% endif %}

################################### Metrics ####################################

## Host to send statsd instrumentation to
## Defaults to: None
{% if STATSD_HOST is defined %}
STATSD_HOST = '{{ STATSD_HOST }}'
{% endif %}

## Port to send statsd instrumentation to
## Defaults to: 8125
STATSD_PORT = {{ STATSD_PORT | default(8125) }}

## Prefix for statsd
## Defaults to: None
{% if STATSD_PREFIX is defined %}
STATSD_PREFIX = '{{ STATSD_PREFIX }}'
{% endif %}

################################################################################

################################# File Loader ##################################

## The root path where the File Loader will try to find images
## Defaults to: /tmp
FILE_LOADER_ROOT_PATH = '{{ FILE_LOADER_ROOT_PATH | default('/data/loader') }}'

################################################################################


################################# HTTP Loader ##################################

## The maximum number of seconds libcurl can take to connect to an image being
## loaded
## Defaults to: 5
HTTP_LOADER_CONNECT_TIMEOUT = {{ HTTP_LOADER_CONNECT_TIMEOUT | default(5) }}

## The maximum number of seconds libcurl can take to download an image
## Defaults to: 20
HTTP_LOADER_REQUEST_TIMEOUT = {{ HTTP_LOADER_REQUEST_TIMEOUT | default(20) }}

## Indicates whether libcurl should follow redirects when downloading an image
## Defaults to: True
HTTP_LOADER_FOLLOW_REDIRECTS = {{ HTTP_LOADER_FOLLOW_REDIRECTS | default(True) }}

## Indicates the number of redirects libcurl should follow when downloading an
## image
## Defaults to: 5
HTTP_LOADER_MAX_REDIRECTS = {{ HTTP_LOADER_MAX_REDIRECTS | default(5) }}

## The maximum number of simultaneous HTTP connections the loader can make before
## queuing
## Defaults to: 10
HTTP_LOADER_MAX_CLIENTS = {{ HTTP_LOADER_MAX_CLIENTS | default(10) }}

## Indicates whether thumbor should forward the user agent of the requesting user
## Defaults to: False
HTTP_LOADER_FORWARD_USER_AGENT = {{ HTTP_LOADER_FORWARD_USER_AGENT | default(False) }}

## Default user agent for thumbor http loader requests
## Defaults to: Thumbor/6.3.0
HTTP_LOADER_DEFAULT_USER_AGENT = '{{ HTTP_LOADER_DEFAULT_USER_AGENT | default('Thumbor/6.3.0') }}'

## The proxy host needed to load images through
## Defaults to: None
HTTP_LOADER_PROXY_HOST = {{ HTTP_LOADER_PROXY_HOST | default(None) }}

## The proxy port for the proxy host
## Defaults to: None
HTTP_LOADER_PROXY_PORT = {{ HTTP_LOADER_PROXY_PORT | default(None) }}

## The proxy username for the proxy host
## Defaults to: None
HTTP_LOADER_PROXY_USERNAME = {{ HTTP_LOADER_PROXY_USERNAME | default(None) }}

## The proxy password for the proxy host
## Defaults to: None
HTTP_LOADER_PROXY_PASSWORD = {{ HTTP_LOADER_PROXY_PASSWORD | default(None) }}

## The filename of CA certificates in PEM format
## Defaults to: None
HTTP_LOADER_CA_CERTS = {{ HTTP_LOADER_CA_CERTS | default(None) }}

## Validate the servers certificate for HTTPS requests
## Defaults to: True
HTTP_LOADER_VALIDATE_CERTS = {{ HTTP_LOADER_VALIDATE_CERTS | default(True) }}

## The filename for client SSL key
## Defaults to: None
HTTP_LOADER_CLIENT_KEY = {{ HTTP_LOADER_CLIENT_KEY | default(None) }}

## The filename for client SSL certificate
## Defaults to: None
HTTP_LOADER_CLIENT_CERT = {{ HTTP_LOADER_CLIENT_CERT | default(None) }}

## If the CurlAsyncHTTPClient should be used
## Defaults to: False
HTTP_LOADER_CURL_ASYNC_HTTP_CLIENT = {{ HTTP_LOADER_CURL_ASYNC_HTTP_CLIENT | default(False) }}


################################################################################


################################# File Storage #################################

## Expiration in seconds for the images in the File Storage. Defaults to one
## month
## Defaults to: 2592000
STORAGE_EXPIRATION_SECONDS = {{ STORAGE_EXPIRATION_SECONDS | default(2592000) }}

## Indicates whether thumbor should store the signing key for each image in the
## file storage. This allows the key to be changed and old images to still be
## properly found
## Defaults to: False
STORES_CRYPTO_KEY_FOR_EACH_IMAGE = {{ STORES_CRYPTO_KEY_FOR_EACH_IMAGE | default(False) }}

## The root path where the File Storage will try to find images
## Defaults to: /tmp/thumbor/storage
FILE_STORAGE_ROOT_PATH = '{{ FILE_STORAGE_ROOT_PATH | default('/data/storage') }}'

################################################################################


#################################### Upload ####################################

## Max size in Kb for images uploaded to thumbor
## Aliases: MAX_SIZE
## Defaults to: 0
UPLOAD_MAX_SIZE = {{ UPLOAD_MAX_SIZE | default(0) }}

## Indicates whether thumbor should enable File uploads
## Aliases: ENABLE_ORIGINAL_PHOTO_UPLOAD
## Defaults to: False
UPLOAD_ENABLED = {{ UPLOAD_ENABLED | default(False) }}

## The type of storage to store uploaded images with
## Aliases: ORIGINAL_PHOTO_STORAGE
## Defaults to: thumbor.storages.file_storage
UPLOAD_PHOTO_STORAGE = '{{ UPLOAD_PHOTO_STORAGE | default('thumbor.storages.file_storage') }}'

## Indicates whether image deletion should be allowed
## Aliases: ALLOW_ORIGINAL_PHOTO_DELETION
## Defaults to: False
UPLOAD_DELETE_ALLOWED = {{ UPLOAD_DELETE_ALLOWED | default(False) }}

## Indicates whether image overwrite should be allowed
## Aliases: ALLOW_ORIGINAL_PHOTO_PUTTING
## Defaults to: False
UPLOAD_PUT_ALLOWED = {{ UPLOAD_PUT_ALLOWED | default(False) }}

## Default filename for image uploaded
## Defaults to: image
UPLOAD_DEFAULT_FILENAME = '{{ UPLOAD_DEFAULT_FILENAME | default('image') }}'

################################################################################


############################### MongoDB Storage ################################

## MongoDB storage server host
## Defaults to: localhost
MONGO_STORAGE_SERVER_HOST = '{{ MONGO_STORAGE_SERVER_HOST | default('mongo') }}'

## MongoDB storage server port
## Defaults to: 27017
MONGO_STORAGE_SERVER_PORT = {{ MONGO_STORAGE_SERVER_PORT | default(27017) }}

## MongoDB storage server database name
## Defaults to: thumbor
MONGO_STORAGE_SERVER_DB = '{{ MONGO_STORAGE_SERVER_DB | default('thumbor') }}'

## MongoDB storage image collection
## Defaults to: images
MONGO_STORAGE_SERVER_COLLECTION = '{{ MONGO_STORAGE_SERVER_COLLECTION | default('images') }}'

################################################################################


################################ Redis Storage #################################

## Redis storage server host
## Defaults to: localhost
REDIS_STORAGE_SERVER_HOST = '{{ REDIS_STORAGE_SERVER_HOST | default('redis') }}'

## Redis storage server port
## Defaults to: 6379
REDIS_STORAGE_SERVER_PORT = {{ REDIS_STORAGE_SERVER_PORT | default(6379) }}

## Redis storage database index
## Defaults to: 0
REDIS_STORAGE_SERVER_DB = {{ REDIS_STORAGE_SERVER_DB | default(0) }}

## Redis storage server password
## Defaults to: None
REDIS_STORAGE_SERVER_PASSWORD = {{ REDIS_STORAGE_SERVER_PASSWORD | default(None) }}

## Ignore Redis storage errors
## Defaults to: True
REDIS_STORAGE_IGNORE_ERRORS = {{ REDIS_STORAGE_IGNORE_ERRORS | default(True) }}

################################################################################


################################ Redis Result Storage #################################

## Redis storage server host
## Defaults to: localhost
REDIS_RESULT_STORAGE_SERVER_HOST = '{{ REDIS_RESULT_STORAGE_SERVER_HOST | default('redis') }}'

## Redis storage server port
## Defaults to: 6379
REDIS_RESULT_STORAGE_SERVER_PORT = {{ REDIS_RESULT_STORAGE_SERVER_PORT | default(6379) }}

## Redis storage database index
## Defaults to: 0
REDIS_RESULT_STORAGE_SERVER_DB = {{ REDIS_RESULT_STORAGE_SERVER_DB | default(0) }}

## Redis storage server password
## Defaults to: None
REDIS_RESULT_STORAGE_SERVER_PASSWORD = {{ REDIS_RESULT_STORAGE_SERVER_PASSWORD | default(None) }}

## Ignore Redis storage errors
## Defaults to: True
REDIS_RESULT_STORAGE_IGNORE_ERRORS = {{ REDIS_RESULT_STORAGE_IGNORE_ERRORS | default(True) }}

################################################################################


############################### Memcache Storage ###############################

## List of Memcache storage server hosts
## Defaults to: ['localhost:11211']
MEMCACHE_STORAGE_SERVERS = {{ MEMCACHE_STORAGE_SERVERS | default(['localhost:11211',]) }}


################################################################################


################################ Mixed Storage #################################

## Mixed Storage file storage. This must be the full name of a python module
## (python must be able to import it)
## Defaults to: thumbor.storages.no_storage
MIXED_STORAGE_FILE_STORAGE = '{{ MIXED_STORAGE_FILE_STORAGE | default('thumbor.storages.no_storage') }}'

## Mixed Storage signing key storage. This must be the full name of a python
## module (python must be able to import it)
## Defaults to: thumbor.storages.no_storage
MIXED_STORAGE_CRYPTO_STORAGE = '{{ MIXED_STORAGE_CRYPTO_STORAGE | default('thumbor.storages.no_storage') }}'

## Mixed Storage detector information storage. This must be the full name of a
## python module (python must be able to import it)
## Defaults to: thumbor.storages.no_storage
MIXED_STORAGE_DETECTOR_STORAGE = '{{ MIXED_STORAGE_DETECTOR_STORAGE | default('thumbor.storages.no_storage') }}'

################################################################################


##################################### Meta #####################################

## The callback function name that should be used by the META route for JSONP
## access
## Defaults to: None
META_CALLBACK_NAME = {{ META_CALLBACK_NAME | default(None) }}

################################################################################


################################## Detection ###################################

## List of detectors that thumbor should use to find faces and/or features. All
## of them must be full names of python modules (python must be able to import
## it)
## Defaults to: []
#DETECTORS =  [
#'thumbor.detectors.queued_detector.queued_complete_detector',
#'thumbor.detectors.queued_detector.queued_face_detector',
#'thumbor.detectors.queued_detector.queued_feature_detector',
#'thumbor.detectors.feature_detector',
#'thumbor.detectors.face_detector',
#]
DETECTORS = {{ DETECTORS | default([]) }}

## The cascade file that opencv will use to detect faces
## Defaults to: haarcascade_frontalface_alt.xml
FACE_DETECTOR_CASCADE_FILE = '{{ FACE_DETECTOR_CASCADE_FILE | default('haarcascade_frontalface_alt.xml') }}'

## The cascade file that opencv will use to detect glasses.
## Defaults to: 'haarcascade_eye_tree_eyeglasses.xml'
GLASSES_DETECTOR_CASCADE_FILE = '{{ GLASSES_DETECTOR_CASCADE_FILE | default('haarcascade_eye_tree_eyeglasses.xml') }}'

## The cascade file that opencv will use to detect profile faces.
## Defaults to: 'haarcascade_profileface.xml'
PROFILE_DETECTOR_CASCADE_FILE = '{{ PROFILE_DETECTOR_CASCADE_FILE | default('haarcascade_profileface.xml') }}'

################################################################################


################################## Optimizers ##################################

## List of optimizers that thumbor will use to optimize images
## Defaults to: [] --> ['thumbor.optimizers.jpegtran',]
OPTIMIZERS = {{ OPTIMIZERS | default([]) }}


## Path for the jpegtran binary
## Defaults to: /usr/bin/jpegtran
JPEGTRAN_PATH = '{{ JPEGTRAN_PATH | default('/usr/bin/jpegtran') }}'
# Path for the progressive scans file to use with jpegtran optimizer. Implies progressive jpeg output
JPEGTRAN_SCANS_FILE = '{{ JPEGTRAN_SCANS_FILE | default('') }}'
PROGRESSIVE_JPEG = {{ PROGRESSIVE_JPEG | default(True) }}
FFMPEG_PATH = '{{ FFMPEG_PATH  | default('/usr/bin/ffmpeg') }}' # Default path for the docker installation in debian

################################################################################


################################### Filters ####################################

## List of filters that thumbor will allow to be used in generated images. All of
## them must be full names of python modules (python must be able to import
## it)
## using thumbor's default, unless specified.
{% if FILTERS is defined %}
FILTERS = {{ FILTERS }}
{% endif %}

################################################################################


################################ Result Storage ################################

## Expiration in seconds of generated images in the result storage
## Defaults to: 0
RESULT_STORAGE_EXPIRATION_SECONDS = {{ RESULT_STORAGE_EXPIRATION_SECONDS | default(0) }}

## Path where the Result storage will store generated images
## Defaults to: /tmp/thumbor/result_storage
RESULT_STORAGE_FILE_STORAGE_ROOT_PATH = '{{ RESULT_STORAGE_FILE_STORAGE_ROOT_PATH | default('/data/result_storage') }}'

## Indicates whether unsafe requests should also be stored in the Result Storage
## Defaults to: False
RESULT_STORAGE_STORES_UNSAFE = {{ RESULT_STORAGE_STORES_UNSAFE | default(False) }}

################################################################################


############################ Queued Redis Detector #############################

## Server host for the queued redis detector
## Defaults to: localhost
REDIS_QUEUE_SERVER_HOST = '{{ REDIS_QUEUE_SERVER_HOST | default('redis') }}'

## Server port for the queued redis detector
## Defaults to: 6379
REDIS_QUEUE_SERVER_PORT = {{ REDIS_QUEUE_SERVER_PORT | default(6379) }}

## Server database index for the queued redis detector
## Defaults to: 0
REDIS_QUEUE_SERVER_DB = {{ REDIS_QUEUE_SERVER_DB | default(0) }}

## Server password for the queued redis detector
## Defaults to: None
REDIS_QUEUE_SERVER_PASSWORD = {{ REDIS_QUEUE_SERVER_PASSWORD | default(None) }}

################################################################################


############################# Queued SQS Detector ##############################

## AWS key id
## Defaults to: None
SQS_QUEUE_KEY_ID = {{ SQS_QUEUE_KEY_ID | default(None) }}

## AWS key secret
## Defaults to: None
SQS_QUEUE_KEY_SECRET = {{ SQS_QUEUE_KEY_SECRET | default(None) }}

## AWS SQS region
## Defaults to: us-east-1
SQS_QUEUE_REGION = '{{ SQS_QUEUE_REGION | default('us-east-1') }}'

################################################################################


#################################### Errors ####################################

## This configuration indicates whether thumbor should use a custom error
## handler.
## Defaults to: False
USE_CUSTOM_ERROR_HANDLING = {{ USE_CUSTOM_ERROR_HANDLING | default(False) }}

## Error reporting module. Needs to contain a class called ErrorHandler with a
## handle_error(context, handler, exception) method.
## Defaults to: thumbor.error_handlers.sentry
ERROR_HANDLER_MODULE = '{{ ERROR_HANDLER_MODULE | default('thumbor.error_handlers.sentry') }}'

## File of error log as json
## Defaults to: None
ERROR_FILE_LOGGER = {{ ERROR_FILE_LOGGER | default(None) }}

## File of error log name is parametrized with context attribute
## Defaults to: False
ERROR_FILE_NAME_USE_CONTEXT = {{ ERROR_FILE_NAME_USE_CONTEXT | default('False') }}

################################################################################


############################### Errors - Sentry ################################

## Sentry thumbor project dsn. i.e.: http://5a63d58ae7b94f1dab3dee740b301d6a:73ee
## a45d3e8649239a973087e8f21f98@localhost:9000/2
## Defaults to:
SENTRY_DSN_URL = '{{ SENTRY_DSN_URL | default('') }}'

################################################################################

################################### General ####################################

# The amount of time to wait before shutting down the server, i.e. stop accepting requests.
MAX_WAIT_SECONDS_BEFORE_SERVER_SHUTDOWN = {{ MAX_WAIT_SECONDS_BEFORE_SERVER_SHUTDOWN | default(0) }}
# The amount of time to waut before shutting down all io, after the server has been stopped
MAX_WAIT_SECONDS_BEFORE_IO_SHUTDOWN = {{ MAX_WAIT_SECONDS_BEFORE_IO_SHUTDOWN | default(0) }}

## Custom app class to override ThumborServiceApp. This config value is
## overridden by the -a command-line parameter.
## Defaults to: 'thumbor.app.ThumborServiceApp'
APP_CLASS = '{{ APP_CLASS | default('thumbor.app.ThumborServiceApp') }}'

################################################################################

############################## TC_AWS ##########################################
TC_AWS_REGION = '{{ TC_AWS_REGION | default('eu-west-1') }}' # AWS Region

# Custom S3 endpoint URL (for GCP, Minio, etc.)
{% if TC_AWS_ENDPOINT is defined %}
TC_AWS_ENDPOINT = '{{ TC_AWS_ENDPOINT }}'
{% endif %}

TC_AWS_STORAGE_BUCKET = '{{ TC_AWS_STORAGE_BUCKET | default('') }}' # S3 bucket for Storage
TC_AWS_STORAGE_ROOT_PATH = '{{ TC_AWS_STORAGE_ROOT_PATH | default('') }}' # S3 path prefix for Storage bucket

TC_AWS_LOADER_BUCKET = '{{ TC_AWS_LOADER_BUCKET | default('') }}' #S3 bucket for loader
TC_AWS_LOADER_ROOT_PATH = '{{ TC_AWS_LOADER_ROOT_PATH | default('') }}' # S3 path prefix for Loader bucket

TC_AWS_RESULT_STORAGE_BUCKET = '{{ TC_AWS_RESULT_STORAGE_BUCKET | default('') }}' # S3 bucket for result Storage
TC_AWS_RESULT_STORAGE_ROOT_PATH = '{{ TC_AWS_RESULT_STORAGE_ROOT_PATH | default('') }}' # S3 path prefix for Result storage bucket

# put data into S3 using the Server Side Encryption functionality to
# encrypt data at rest in S3
# https://aws.amazon.com/about-aws/whats-new/2011/10/04/amazon-s3-announces-server-side-encryption-support/
TC_AWS_STORAGE_SSE = {{ TC_AWS_STORAGE_SSE | default(False) }}

# put data into S3 with Reduced Redundancy
# https://aws.amazon.com/about-aws/whats-new/2010/05/19/announcing-amazon-s3-reduced-redundancy-storage/
TC_AWS_STORAGE_RRS = {{ TC_AWS_STORAGE_RRS | default(False) }}

# Add some randomization in the S3 keys for the Storage and Result Storage.
# Defaults to False for Backwards Compatibility, set it to True for performance.
TC_AWS_RANDOMIZE_KEYS = {{ TC_AWS_RANDOMIZE_KEYS | default(False) }}

# Enable HTTP Loader as well?
# This would allow you to load watermarks in over your images dynamically through a URI
# E.g.
# http://your-thumbor.com/unsafe/filters:watermark(http://example.com/watermark.png,0,0,50)/s3_bucket/photo.jpg
TC_AWS_ENABLE_HTTP_LOADER = {{ TC_AWS_ENABLE_HTTP_LOADER | default(False) }}

TC_AWS_ALLOWED_BUCKETS = {{ TC_AWS_ALLOWED_BUCKETS | default(False) }} # List of allowed bucket to be requested
TC_AWS_STORE_METADATA = {{ TC_AWS_STORE_METADATA | default(False) }} # Store result with metadata (for instance content-type)
################################################################################

########################## Google Cloud Storage ################################
CLOUD_STORAGE_BUCKET_ID = '{{ CLOUD_STORAGE_BUCKET_ID | default('') }}'
CLOUD_STORAGE_PROJECT_ID = '{{ CLOUD_STORAGE_PROJECT_ID | default('') }}'

RESULT_STORAGE_CLOUD_STORAGE_PROJECT_ID = '{{ RESULT_STORAGE_CLOUD_STORAGE_PROJECT_ID | default('') }}'
RESULT_STORAGE_CLOUD_STORAGE_BUCKET_ID = '{{ RESULT_STORAGE_CLOUD_STORAGE_BUCKET_ID | default('') }}'
################################################################################

######################### tc_prometheus ########################################
PROMETHEUS_SCRAPE_PORT = {{ PROMETHEUS_SCRAPE_PORT | default(8000) }} # Port the prometheus client should listen on
