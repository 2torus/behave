@issue
Feature: Issue #____ running behave with capturing erases sys.stdout.encoding

    Scenario Outline: When behave runs code that uses sys.stdout.encoding or sys.stderr.encoding , the code will not fail.
        Given a new working directory
        And a file named "features/steps/sys_stream_encoding_steps.py" with:
            """
            from behave import step
            import sys

            @step('a code that uses sys.{stream}.encoding')
            def use_stdout_encoding(context, stream):
                stream = getattr(sys, stream)
                _ = "Hello".encode(stream.encoding)
            """
        And a file named "features/example.feature" with:
            """
            Feature:
                Scenario:
                    Given a code that uses sys.<stream>.encoding
            """
        When I run "behave --capture features/example.feature"
        Then it should pass

    Examples:
            | stream |
            | stdout |
            | stderr |