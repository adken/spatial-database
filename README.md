# Exercise 13: Database backend for a Web GIS

## Objectives

In this exercise, you create an entire database as a Web GIS backend.
You will need to use and implement many methods, approaches, and
software you learned during the semester.

## Possible context

You work at the event company Vudstork Entertainment Ltd which is in
charge of organizing a city festival for a medium-sized city. With your
background in Geoinformatics, you suggest developing a mobile app that
allows visitors to obtain a lot of information about this festival.
Further, the organizers want to use this app to distribute notifications
and improve their organization workflows in general. The backbone of
this app is a spatial database, for which you are an expert now. Hence,
the database has the following requirements:

-   Serve as database backend to organize the booths, roller coasters,
    tents etc. (Positions, opening times, \...) as well as other
    facilities (garbage bins, toilets etc.)

-   User-specific, dynamic queries that return which events take place
    or facilities that are close to the current visitor\'s position.

-   User-specific and dynamic queries about the festival (digital maps,
    lists of events etc.

## Tasks

Create a database for a city festival (choose any, e.g., of your
hometown or create a ﬁctional one) as a backend for a Web GIS. Search
for information that you can use for data modelling. The database itself
should (if no reasons are given) be in the third normal form. Import
data and de-normalize -- if necessary, with views. Create indexes where
required. Create at least three queries for the application that is
deﬁned in the second requirement to document that the database works.

## Trade Show 

For this assignment, I will create a database for a trade show which is
an annual show organized by the Uganda Manufacturers Association(UMA).
The week-long show is an opportunity for manufacturers, businesses, and
companies to showcase their products and services to visitors/the
general public.

In modelling this database, the following assumptions will be made to
simplify the modelling process

-   Information on the event can be accessed online on the event
    organizer's website hence the need for the database.

-   Visitors want information about the events at the trade show,
    opening and closing dates and times, the services available, ticket
    prices, and various facilities available for their use.

-   All facilities at the show will be modelled as "point" feature type

-   Tickets to the event can be bought at the venue or online, so there
    will be a tickets office

-   The tickets are valid for a period of time, 1 day, 2 days or the
    whole duration of the event.

-   Visitors have to pay for some services while at the show, these
    services are not covered by the ticket cost. Services such as food
    and drinks or buying products at the exhibition halls.

-   The organizer's employees are assigned different roles for the show
    and are responsible for ensuring that their roles are executed
    successfully.

-   The company has sponsors who are grouped under different packages
    depending on the sponsorship amount.

-   The company has prequalified service providers for the show. The
    service providers can provide one service or none at the show.

-   The organizing company allocates space to participating businesses
    and companies, space is also allocated to service providers in form
    of offices. The space allocated is in the form of event halls to
    exhibitors (participating companies or businesses).

### Task 1: Database modelling

The database is modelled in such a way that it meets the following
requirements for the visitors and organization:

-   Serve as database backend to organize facilities (toilets, garbage
    bins, etc.), events (venue, opening times, \...)

    -   Schedule of events with opening and closing times

    -   Positions of facilities such as Garbage bins, toilets

    -   Entry and exit points

    -   Emergency and safety areas

-   User-specific, dynamic queries that return which events take place
    or facilities that are close to the current visitor\'s position.

    -   Views and dynamic queries

    -   How many facilities are within a distance of an event's
        location?

    -   What is the distance from one facility to another?

-   User-specific and dynamic queries about the trade show (digital
    maps, lists of events etc.

    -   Map of facilities of a particular type

    -   Location of facilities: tickets, food, security, toilet, exit
        and entry point

The database tables, relationship between tables, attributes and
attribute types are shown in the database model below:

![logical model](https://user-images.githubusercontent.com/29119766/227719989-29fc0fd7-b7b2-4f30-884f-fc52d64f57e1.jpg)

Figure 1: Data model for the webgis_backend database


### Task 2: Creating the database, spatial extension, and database tables

The next task is creating the database **webgis_backend.** The PostGIS
extension was created to enable support for spatial data in the
database.

Database tables, attributes, and attribute datatypes are then created
according to the defined data model. Relation between tables is also
defined using PRIMARY and FOREIGN keys.

<img width="393" alt="image" src="https://user-images.githubusercontent.com/29119766/227720332-073e22c8-1755-4f38-806a-0f42a0f32fcd.png">
Figure 2: Creating the database table for events

<img width="391" alt="image" src="https://user-images.githubusercontent.com/29119766/227720368-3379a7c9-8bbe-4e18-a3ef-993d02d5c643.png">
Figure 3: Creating database table for trade show

### Task 3: Importing data into database tables

The created database tables are populated with dummy data, spatial data
for the facilities is created from OSM data.

<img width="463" alt="image" src="https://user-images.githubusercontent.com/29119766/227720379-ad0d64af-0858-4b16-9502-6d63dbd07b79.png">
Figure 4: Inserting data into the tradeshow table

<img width="454" alt="image" src="https://user-images.githubusercontent.com/29119766/227720392-81a66273-d4f5-430e-8f65-3e8a2ce50c07.png">
Figure 5: Inserting data into ticket table showing ticket information

<img width="454" alt="image" src="https://user-images.githubusercontent.com/29119766/227720409-117ecdf7-ac46-4c8e-829d-be05ab39e1b5.png">
Figure 6: Inserting data into the events table showing all the events at
the trade show

### Task 4: Views and Indexes

Spatial indexes are created for the facility table which shows the
location of all the facilities at the trade show. The events at the show
take place at certain facilities.

Since the events and facilities tables are only linked by a foreign key,
a query can be created to return a JOIN of all planned events and the
respective facility names and locations for the planned events. The
results of this query are stored in a database view event_schedule.

<img width="454" alt="image" src="https://user-images.githubusercontent.com/29119766/227720427-9af5d612-1a6d-4126-966f-841dddfd7f4c.png">
Figure 7: Database view event_schedule to link facilities and events

### Task 5: Database queries

Some of the possible queries and their results are shown below. These
include queries to calculate distance from one facility to another,
selecting facilities within a distance of an event, and selecting all
facilities of a particular type.

<img width="418" alt="image" src="https://user-images.githubusercontent.com/29119766/227720449-4c846256-c7b6-4e43-9a01-82771b0f141a.png">
Figure 8: Query on the event_schedule view

<img width="410" alt="image" src="https://user-images.githubusercontent.com/29119766/227720459-02e5cb73-0e6b-4360-a523-3440baee8b31.png">
Figure 9: Spatial query to return facilities of the type event hall

<img width="454" alt="image" src="https://user-images.githubusercontent.com/29119766/227720671-46308530-5cbc-4ffd-b8cf-a4216ba55417.png">
Figure 10: Map of event halls and other facility types

Assuming, a visitor is at an event at Event Hall P, and he/she is
curious to find out all facilities within 50m of his/her current
position, the query below achieves that.

<img width="454" alt="image" src="https://user-images.githubusercontent.com/29119766/227720696-1cfa69aa-cf0b-4a61-a84d-8631502a7628.png">
Figure 11: Query to select all facilities within 50m of Event Hall P

The facilities are identified by name and ID numbers, to calculate the
distance from one facility to another, the ID is used. In the query
below, we calculate the distance from the event hall P with ID 1 to the
tickets office with ID 5.

<img width="453" alt="image" src="https://user-images.githubusercontent.com/29119766/227720586-20c91794-0717-449c-8241-884c6df94567.png">
Figure 12: Selecting the first 5 Facilities.

<img width="454" alt="image" src="https://user-images.githubusercontent.com/29119766/227720564-45b924e6-7cc7-49c4-8a77-123fbe47ae76.png">
Figure 13: Calculating distance in meters from Event Hall P to ticket office.
