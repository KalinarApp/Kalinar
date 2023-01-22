# Datenbank-Migrationen

### Neue Migration generieren
```
Add-Migration <migration_name> -StartupProject Hero.Server.DataAccess -Project Hero.Server.DataAccess
```

### Migration anwenden
Das Ausführen der Migrationen geschieht automatisch beim Anwendungsstart wenn **ASPNETCORE_ENVIRONMENT=Development**.
Ansonsten kann man eine Migration wie folgt anwenden:
```
Update-Database -StartupProject Hero.Server.DataAccess -Project Hero.Server.DataAccess
```

### Migration zurücksetzen
```
Update-Database <previous_migration_name> -StartupProject Hero.Server.DataAccess -Project Hero.Server.DataAccess

### Alle Migrationen entfernen
```
Update-Database 0 -StartupProject Hero.Server.DataAccess -Project Hero.Server.DataAccess
Remove-Migration -StartupProject Hero.Server.DataAccess -Project Hero.Server.DataAccess
```
