@IsTest
private class AccountServiceTest {

    @IsTest
    static void testCreateAccount() {

        Test.startTest();

        Account acc = AccountService.createAccount(
            'ABC Technologies',
            '9876543210'
        );

        Test.stopTest();

        System.assertNotEquals(null, acc.Id);
        System.assertEquals('ABC Technologies', acc.Name);
        System.assertEquals('9876543210', acc.Phone);
    }

    @IsTest
    static void testGetAccount() {

        Account acc = new Account(
            Name = 'Google',
            Phone = '1111111111'
        );

        insert acc;

        Test.startTest();

        Account result = AccountService.getAccount(acc.Id);

        Test.stopTest();

        System.assertEquals(acc.Id, result.Id);
        System.assertEquals('Google', result.Name);
        System.assertEquals('1111111111', result.Phone);
    }

    @IsTest
    static void testUpdatePhone() {

        Account acc = new Account(
            Name = 'Microsoft'
        );

        insert acc;

        Test.startTest();

        AccountService.updatePhone(
            acc.Id,
            '9999999999'
        );

        Test.stopTest();

        Account updated = [
            SELECT Phone
            FROM Account
            WHERE Id = :acc.Id
        ];

        System.assertEquals(
            '9999999999',
            updated.Phone
        );
    }

    @IsTest
    static void testDeleteAccount() {

        Account acc = new Account(
            Name = 'Oracle'
        );

        insert acc;

        Test.startTest();

        AccountService.deleteAccount(acc.Id);

        Test.stopTest();

        Account deletedAcc = [
            SELECT Id, IsDeleted
            FROM Account
            WHERE Id = :acc.Id
            ALL ROWS
        ];

        System.assertEquals(true, deletedAcc.IsDeleted);
    }

    @IsTest
    static void testCreateAccountWithBlankName() {

        Test.startTest();

        try {

            AccountService.createAccount(
                '',
                '1234567890'
            );

            System.assert(false, 'Expected exception was not thrown.');

        } catch (IllegalArgumentException ex) {

            System.assertEquals(
                'Account Name cannot be blank',
                ex.getMessage()
            );
        }

        Test.stopTest();
    }
}