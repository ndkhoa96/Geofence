# Geofence area

The goal of this assignment is to create an iOS application that will detect if the device is located inside of a geofence area.

### Author: Khoa Nguyen

![alt text](https://github.com/ndkhoa96/Assignment_iOS/blob/main/resource/app_main_screen.png)

a/ Project is using:

- Pure Swift
- Framework: UIKit, MapKit, CoreLocation, XCTest
- Clean architrecture [here](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html), use this as high level guideline.
- Being devided in 3 layers:
  - Domain Layer = Entities + Use Cases + Repositories Interfaces
  - Data Layer = Repositories Implementations
  - Presentation Layer (MVC) = Views + ViewController
- SOLID principles [here](https://www.google.com/search?sxsrf=ALeKk01XtOekOpJvhSePYEwrjdVNe2ZNfw%3A1593035218071&ei=0snzXo7VA8i2kwXo66iQAw&q=solid+principles+origin&oq=solid+principles+origi&gs_lcp=CgZwc3ktYWIQAxgAMgIIADoECAAQRzoECAAQQzoGCAAQFhAeOgcIABAUEIcCOggIABAWEAoQHlC6UljoYWCuaGgCcAF4AIABYogBtASSAQE4mAEAoAEBqgEHZ3dzLXdpeg&sclient=psy-ab)

![alt text](https://github.com/ndkhoa96/Assignment_iOS/blob/main/resource/CleanArchitecture.png)

b/ I have structured the project into 3 main layers:

```
    - Domain: this contains 2 main things:
        - Entities: represent for Enterprise business roles
        - Usecases: represent for Application roles
    - Presentation: View+Controller by using MVC
    - Data: using UserDefaults for store data model GeoArea.
```

Beside that, there are `Common, Utility` folders, ... do what their names say.

Some key frameworks:

    - CoreLocation: Obtain the geographic location and orientation of a device.
    - XCTest: use for writing unit tests.

c/ Run project by open `assignment_geofence.xcodeproj` file.
