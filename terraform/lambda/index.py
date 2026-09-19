import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def handler(event, context):

    logger.info("Centralized logging demo Lambda executed")

    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "Logging demo successful"
        })
    }