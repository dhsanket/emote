package com.emote

class FlagService {

    def create(Flag flag) {
        flag.save(true);
        return flag
    }
}
