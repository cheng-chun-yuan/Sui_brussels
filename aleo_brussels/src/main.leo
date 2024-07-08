// The 'brussels' program.
program brussels_wc_222.aleo {
    record Token {
        // The token owner, any record must be defined with the `owner` field.
        owner: address,
        // Token balance of the user.
        amount: u64,
    }
    transition mint(owner: address, amount: u64) -> Token {
        return Token {
            owner: owner,
            amount: amount,
        };
    }
    transition transfer(token: Token, to: address, amount: u64) -> (Token, Token) {
        // Checks the given token record has sufficient balance.
        // This `sub` operation is safe, and the proof will fail
        // if an overflow occurs.
        // `difference` holds the change amount to be returned to sender.
        let difference: u64 = token.amount - amount;

        // Produce a token record with the change amount for the sender.
        let remaining: Token = Token {
            owner: token.owner,
            amount: difference,
        };

        // Produce a token record for the specified receiver.
        let transferred: Token = Token {
            owner: to,
            amount: amount,
        };

        // Output the sender's change record and the receiver's record.
        return (remaining, transferred);
    }
    transition balance_of(token: Token) -> u64 {
        return token.amount;
    }
}