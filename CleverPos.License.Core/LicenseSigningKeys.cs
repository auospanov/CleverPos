namespace CleverPos.License.Core
{
    /// <summary>
    /// Default RSA key pair for CleverPos licence signing.
    /// Private key must stay on the server / LicenseGenerator only.
    /// Public key is embedded in POS for offline verification.
    /// </summary>
    public static class LicenseSigningKeys
    {
        public const string DefaultPublicKeyXml =
            "<RSAKeyValue><Modulus>rUxawq8wBsms3qxTXDua0Jgi2cGeEmp+qXEjmHq/6imb5pA6sAimwOGNIRc8/lJDxFgvuT9k5KlF8JpXHXslaQh0k/MeEchyMYAZNIAafiewiYEf5Yfa+TfhNZWBbMpUN4nzYIVWkW3IQWKiK+Rv8j7I0/f0havn8mSspL/YxpdlkQEj5DVUGmzlSmsvKBLE3+pWHS9WSHVXXoyjRPmpWfH/bdi9XoZraY5D9ArRngBXLsSlONnxJxr1ZcHFlzki5n8wCsgwdov0Nfjvlj7MGc27drV1JJ5oP+hC2jijux43jzeza+kvaR9C1+zhpvjljQ3XxSy/bfjUfLOV8c7tFQ==</Modulus><Exponent>AQAB</Exponent></RSAKeyValue>";

        public const string DefaultPrivateKeyXml =
            "<RSAKeyValue><Modulus>rUxawq8wBsms3qxTXDua0Jgi2cGeEmp+qXEjmHq/6imb5pA6sAimwOGNIRc8/lJDxFgvuT9k5KlF8JpXHXslaQh0k/MeEchyMYAZNIAafiewiYEf5Yfa+TfhNZWBbMpUN4nzYIVWkW3IQWKiK+Rv8j7I0/f0havn8mSspL/YxpdlkQEj5DVUGmzlSmsvKBLE3+pWHS9WSHVXXoyjRPmpWfH/bdi9XoZraY5D9ArRngBXLsSlONnxJxr1ZcHFlzki5n8wCsgwdov0Nfjvlj7MGc27drV1JJ5oP+hC2jijux43jzeza+kvaR9C1+zhpvjljQ3XxSy/bfjUfLOV8c7tFQ==</Modulus><Exponent>AQAB</Exponent><P>xp3OZ8eKTiqX+NywHqrdj+T6jji/vqilizlJhPaqf1LRPSFoyv8PUyI3nxkn+KKgFFevIAc6UQFymcX9gn69we8BzpXble+8eZpDKrmG5khoSolW4/R+dAOYBtsby4LhWOKfzuGj3YR7TaYajIIc3WrFYxcr9GAHYWR8LoZbJus=</P><Q>313zIipCDc+xtQpAcfxLp4JAC14jLd8JHRB99AuUJxyHsNPrMNX2NKt3YXqQYMJioFU6Ns+RJViMjlBlbul+Vhk4uirrDuupZoaGALWON/sj5aSTpftBrfavjDtnLJ9TYhGRS8sW+UZ5qyi0/iCrcVlEI1nZs0yYa7TrWRRhO/8=</Q><DP>L/DpYH12sdVwJ17FmDFwF4qSu/+QsOmuQ8PJLjIIB4GrBdFppQ4Z2dw5hsqgrlA6yY48tENqXSE3U0zKG1SSYxxY2E+t2Cws10FYExkDKdSyb8Nk2NMsLr6rVIRQ2je2Qyk4n8wxLIgM5zo/0EibxQo/qOJv9qWzQlvp6aT+nY8=</DP><DQ>EWtrRbPT+O3EpyDIi9soL0UaJ4jM54voUwrxN7IbeL1h26l7QxC8pbjlk4WSculV9bkP1Cx13lq8g3DDqFWvU5md8e7c7An26Rb+plmCYN1GHGesWBpzMdT2NdKAJlu6jgBeu3F4NjKH1JBVJSh5Flrm1HbyYmhLzsKKRCUxvBM=</DQ><InverseQ>Eo+ZPkdO5EPyn/ZG/gy2w5mU3mLYbcSoVKWeSjRo5aG4qA6FlDTlUIpknin090IUI05X2gDsxDWzqJ3dkCZedd9s8qDJSydPuwybQHU+RsazbfHvnR1x3re5PGNqOnruUmU7JEwVCyuKPo97GnNMVBzWFOeAQxiThQUmoJOi/wA=</InverseQ><D>OYKuWA91W7tQADGmFGS/ctwaLLPBdpEa6bZfPrn1uIsIbtKMd2DXngj8IfApUKkSTjWJ2Os921iFmlxN7r2wY5PnxDWZVAN2ShEdzDt7D0SypF9Sq4STWcN+nJ657dWTbz77opt9aBPLsk8+TFyp/fVyBk4yOq4a8mkQljgIg5aslqYdu8G0Hk4xknTd5yAaz+NaKCNxsQT+k2D/LlgLlrkngBxmcfBxGIhWPr//n8IkTP3vnED75deFIgLxXYqiMbMM5VVv9BQF9CX+7ZQ6WXE0/PpCZjAhl/fEfKlsgflyXawpwsBprkuQeEfhWcWaNKmXJ9s1WffmqMBTvfesHQ==</D></RSAKeyValue>";
    }
}
