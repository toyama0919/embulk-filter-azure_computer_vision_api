module Embulk
  module Filter
    ENDPOINT_PREFIX = "https://api.projectoxford.ai/vision/v1.0"
    RETRY_WAIT_REGEXP = /Rate limit is exceeded. Try again in ([\d]+) seconds./
  end
end