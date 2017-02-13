package com.lutrovnik.register

import org.scalatest.FunSpec
import org.scalatest.BeforeAndAfter

class RegisterSpec extends FunSpec with BeforeAndAfter {
    
    var reg = new Register

    before {
        reg = new Register
    }

    describe("A cash register") {
        it("shows the change") {
            reg.state = Array(1, 2, 3, 4, 5)
            assert(reg.show === "$68 1 2 3 4 5")
        }

        it("puts the money in") {
            assert(reg.put(Array("1", "2", "3", "4", "5")) === "$68 1 2 3 4 5")
            assert(reg.put(Array("1", "2", "3", "4", "5")) === "$136 2 4 6 8 10")
        }

        it("takes the money out") {
            reg.state = Array(1, 2, 3, 4, 5)
            assert(reg.take(Array("0", "0", "1", "1", "1")) === "$60 1 2 2 3 4")
            assert(reg.take(Array("1", "2", "3", "4", "5")) === "Register doesn't have so much money")
        }

        it("calculates the change") {
            reg.state = Array(1, 0, 3, 4, 0)
            assert(reg.change("11") === "0 0 1 3 0")
            assert(reg.show === "$32 1 0 2 1 0")
            assert(reg.change("14") === "sorry")
        }
    }
}
