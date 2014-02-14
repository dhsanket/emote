package com.emote.util

/**
 * Utility class that contains information of a paged result
 */
class PagedResult<T> {

    /**
     * Actual paged results
     */
    List<T> list = []

    /**
     * True if more results are available
     */
    boolean moreResults = false

    /**
     * Retrieved page number
     */
    Integer page = 0
}
