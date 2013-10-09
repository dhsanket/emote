package com.emote

class ExpressionIdea {
    String text
    String goodOrBad

    static constraints = {
    }

    boolean equals(o) {
        if (this.is(o)) return true
        if (getClass() != o.class) return false

        ExpressionIdea that = (ExpressionIdea) o

        if (text != that.text) return false

        return true
    }

    int hashCode() {
        return text.hashCode()
    }
}
