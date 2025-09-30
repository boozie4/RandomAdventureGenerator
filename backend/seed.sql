-- seed.sql (idempotent)
USE random_adventures;

-- Insert rows only if the text doesn't already exist
INSERT INTO adventures (text, categories)
SELECT * FROM (
	SELECT 'Try a new restaurant within 5 miles' AS text, JSON_ARRAY('Social','Chill') AS categories
) AS tmp
WHERE NOT EXISTS (
	SELECT 1 FROM adventures WHERE text = 'Try a new restaurant within 5 miles'
);

INSERT INTO adventures (text, categories)
SELECT * FROM (
	SELECT 'Visit a local museum' AS text, JSON_ARRAY('Creative','Social') AS categories
) AS tmp
WHERE NOT EXISTS (
	SELECT 1 FROM adventures WHERE text = 'Visit a local museum'
);

INSERT INTO adventures (text, categories)
SELECT * FROM (
	SELECT 'Listen to a new podcast' AS text, JSON_ARRAY('Chill') AS categories
) AS tmp
WHERE NOT EXISTS (
	SELECT 1 FROM adventures WHERE text = 'Listen to a new podcast'
);

INSERT INTO adventures (text, categories)
SELECT * FROM (
	SELECT 'Take a walk in the park' AS text, JSON_ARRAY('Physical','Chill') AS categories
) AS tmp
WHERE NOT EXISTS (
	SELECT 1 FROM adventures WHERE text = 'Take a walk in the park'
);

INSERT INTO adventures (text, categories)
SELECT * FROM (
	SELECT 'Watch a sunset' AS text, JSON_ARRAY('Chill','Creative') AS categories
) AS tmp
WHERE NOT EXISTS (
	SELECT 1 FROM adventures WHERE text = 'Watch a sunset'
);

INSERT INTO adventures (text, categories)
SELECT * FROM (
	SELECT 'Sketch a street scene for 20 minutes' AS text, JSON_ARRAY('Creative') AS categories
) AS tmp
WHERE NOT EXISTS (
	SELECT 1 FROM adventures WHERE text = 'Sketch a street scene for 20 minutes'
);

INSERT INTO adventures (text, categories)
SELECT * FROM (
	SELECT 'Join a short local meetup or event' AS text, JSON_ARRAY('Social') AS categories
) AS tmp
WHERE NOT EXISTS (
	SELECT 1 FROM adventures WHERE text = 'Join a short local meetup or event'
);

INSERT INTO adventures (text, categories)
SELECT * FROM (
	SELECT 'Try a new workout class' AS text, JSON_ARRAY('Physical') AS categories
) AS tmp
WHERE NOT EXISTS (
	SELECT 1 FROM adventures WHERE text = 'Try a new workout class'
);

INSERT INTO adventures (text, categories)
SELECT * FROM (
	SELECT 'Prepare a new recipe from a different cuisine' AS text, JSON_ARRAY('Creative','Chill') AS categories
) AS tmp
WHERE NOT EXISTS (
	SELECT 1 FROM adventures WHERE text = 'Prepare a new recipe from a different cuisine'
);
