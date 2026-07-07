public with sharing class AccountService {

    // Create Account
    public static Account createAccount(String accName, String phone) {

        if (String.isBlank(accName)) {
            throw new IllegalArgumentException('Account Name cannot be blank');
        }

        Account acc = new Account(
            Name = accName,
            Phone = phone
        );

        insert acc;
        return acc;
    }

    // Get Account
    public static Account getAccount(Id accountId) {

        return [
            SELECT Id, Name, Phone
            FROM Account
            WHERE Id = :accountId
            LIMIT 1
        ];
    }

    // Update Phone
    public static void updatePhone(Id accountId, String phone) {

        Account acc = [
            SELECT Id, Phone
            FROM Account
            WHERE Id = :accountId
            LIMIT 1
        ];

        acc.Phone = phone;
        update acc;
    }

    // Delete Account
    public static void deleteAccount(Id accountId) {

        Account acc = [
            SELECT Id
            FROM Account
            WHERE Id = :accountId
            LIMIT 1
        ];

        delete acc;
    }
}