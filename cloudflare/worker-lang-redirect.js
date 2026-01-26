/**
 * Optional Cloudflare Worker: default language redirect on root path "/"
 *
 * Behavior:
 * - Only runs on exact "/" (and maybe "/?..." variants)
 * - If user has cookie "lang=zh" or "lang=en", respect it
 * - Else redirect by country code (CN -> zh ("/"), others -> "/en/")
 * - Deep links are untouched
 *
 * NOTE: This is an optional add-on. The site works without it.
 */
export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);

    // Only handle root path (no forced redirect on deep links)
    if (url.pathname !== "/") return fetch(request);

    const cookie = request.headers.get("Cookie") || "";
    const langMatch = cookie.match(/(?:^|;\s*)lang=(zh|en)(?:;|$)/);
    if (langMatch?.[1] === "en") {
      url.pathname = "/en/";
      return Response.redirect(url.toString(), 302);
    }
    if (langMatch?.[1] === "zh") {
      // already "/"
      return fetch(request);
    }

    // Cloudflare provides country in request.cf.country
    const country = (request.cf && request.cf.country) ? request.cf.country.toUpperCase() : "XX";
    if (country && country !== "CN") {
      url.pathname = "/en/";
      return Response.redirect(url.toString(), 302);
    }

    return fetch(request);
  },
};
