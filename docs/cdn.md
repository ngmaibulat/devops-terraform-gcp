### GCP CDN caching

-   It caches responses to GET and HEAD requests only.
-   It doesn't cache responses to requests with the Cache-Control: no-store, no-cache, or private directives.
-   It doesn't cache responses that have Set-Cookie headers.
-   It doesn't cache responses to requests that have Authorization headers.

### Cache-Control header

The `Cache-Control` HTTP header is used to specify directives for caching mechanisms in both requests and responses. Different directives have different effects, and they can be divided into several categories based on their function:

**1. Cacheability:**

-   `public`: The response may be stored by any cache, even if the response is normally non-cacheable or even if the request is authenticated.

-   `private`: The response is specific to a user and must not be cached by a shared cache. A private browser cache may store the response.

-   `no-cache`: The cache must validate the freshness of the response with the origin server before serving a cached response, even if the cache thinks the response is not yet stale.

-   `no-store`: The cache should not store the response to avoid inappropriate use or retention of sensitive information.

**2. Expiration:**

-   `max-age=<seconds>`: Specifies the maximum amount of time a resource will be considered fresh. Its value is a non-negative integer representing these seconds.

-   `s-maxage=<seconds>`: Like `max-age`, but it only applies to shared (e.g., proxy) caches.

-   `max-stale[=<seconds>]`: Indicates the client is willing to accept a stale response, optionally for the amount of time in seconds.

-   `min-fresh=<seconds>`: Indicates the client wants a response that will still be fresh for at least the specified number of seconds.

-   `no-transform`: Doesn't allow a proxy to change the media type of the resource.

-   `must-revalidate`: Indicates that once a resource becomes stale, caches must not use their stale copy without successful validation on the origin server.

-   `proxy-revalidate`: Same as `must-revalidate`, but it only applies to shared caches.

-   `stale-while-revalidate=<seconds>`: Indicates the client is willing to accept a stale response while asynchronously checking in the background for a fresh one.

-   `stale-if-error=<seconds>`: Indicates the client is willing to accept a stale response if the check for a fresh one fails.

**3. Other:**

-   `immutable`: Indicates that the response body will not change over time. It allows caches to avoid revalidating unnecessarily.

-   `no-transform`: Doesn't allow a proxy to change the entity-body.

-   `only-if-cached`: The cache should either respond using a stored response, or respond with a `504 (Gateway Timeout)` status.

Keep in mind that `Cache-Control` directives are case-insensitive and can be combined in a comma-separated list. For instance, `Cache-Control: private, max-age=600` would indicate a response that can be cached in a private cache and that it's considered fresh for 600 seconds.

### Other headers

In addition to the `Cache-Control` header, several other HTTP headers play a role in caching. Here's a quick summary:

**Headers that SHOULD be used for caching:**

1. `ETag`: This is used for cache validation to determine if a previously cached response still matches the current version of the resource on the server.

2. `Last-Modified`: This provides the date and time when the server believes the resource was last modified. Like the `ETag`, it's used for cache validation.

3. `Vary`: This header tells the cache that the response of the request may be different, even if the URL is the same, based on different aspects of the request. For example, if `Vary: Accept-Encoding` is specified, the same URL requested with different `Accept-Encoding` headers could return different responses, and the cache should store these separately.

**Headers that USED TO BE used but should generally be avoided now:**

1. `Expires`: This provides a date/time after which the response is considered stale. It used to be the primary method of controlling cache behavior, but `Cache-Control` is much more flexible and precise, so it's generally recommended to use `Cache-Control` instead.

2. `Pragma`: This is a legacy HTTP/1.0 header. The only relevant directive for modern systems is `Pragma: no-cache`, which is equivalent to `Cache-Control: no-cache`. You should generally use `Cache-Control` instead of `Pragma`.

These headers give you more control and flexibility than `Expires` and `Pragma`, and they're better understood by modern browsers and caching proxies. But keep in mind that it's a good idea to include `Expires` if you need to support very old clients that don't understand `Cache-Control`.

Also, remember that correct cache handling requires cooperation between the server and the client (and any intermediaries like caching proxies). The server provides these headers to suggest how the client should handle caching, but it's ultimately up to the client and proxies to obey them. In certain cases, for example, a browser may choose to ignore caching directives under certain conditions, such as when the user explicitly refreshes a page.
