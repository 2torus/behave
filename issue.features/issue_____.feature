@issue
Feature: Issue #____ running behave with capturing erases sys.stdout.encoding

    Scenario: When behave runs code that uses sys.stdout.encoding, the code will not fail.
        Given a new working directory
        And a file named "features/steps/sys_stdout_encoding_steps.py" with:
            """
            from behave import step
            import sys

            @step('a code that uses sys.stdout.encoding')
            def use_stdout_encoding(context):
                _ = "Hello".encode(sys.stdout.encoding)
            """
        And a file named "features/example.feature" with:
            """
            Feature:
                Scenario:
                    Given a code that uses sys.stdout.encoding
            """
        When I run "behave -f plain --capture features/example.feature"
        Then it should pass



    Scenario: When behave runs code that uses sys.stderr.encoding, the code will not fail.
        Given a new working directory
        And a file named "features/steps/sys_stderr_encoding_steps.py" with:
            """
            from behave import step
            import sys

            @step('a code that uses sys.stderr.encoding')
            def use_stderr_encoding(context):
                _ = "Hello".encode(sys.stderr.encoding)
            """
        And a file named "features/example.feature" with:
            """
            Feature:
                Scenario:
                    Given a code that uses sys.stderr.encoding
            """
        When I run "behave -f plain --capture features/example.feature"
        Then it should pass