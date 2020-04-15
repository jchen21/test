package test;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.stream.IntStream;

import org.apache.geode.cache.Region;
import org.apache.geode.cache.client.ClientCache;
import org.apache.geode.cache.client.ClientCacheFactory;
import org.apache.geode.cache.client.ClientRegionShortcut;

public class GeodeClient {

  private static final String LOCATOR = "geode-vm-0.c.data-g2c.internal";

  private static final int LOCATOR_PORT = 10334;

  private static final String REGION_NAME = "testRegion";

  private static final String REGION_NAME_1 = "testRegion1";

  private static final String REGION_NAME_2 = "testRegion2";

  private static final long numEntries = 100_000_000;

  private static final int numThreads = 20;

  private void populateRegion(Region region) throws InterruptedException {
    System.out.println("Populate region " + region.getName());
    ExecutorService executorService = startWorkers(region);
    executorService.shutdown();
    boolean terminated =  executorService.awaitTermination(Long.MAX_VALUE, TimeUnit.NANOSECONDS);
    if (!terminated) {
      System.out.println("Warning: the timeout elapsed before termination.");
    }
  }

  private ExecutorService startWorkers(Region region) {
    ExecutorService executorService = Executors.newFixedThreadPool(numThreads);
    long batchSize = numEntries / numThreads;
    IntStream.range(0, numThreads).forEach(threadId -> {
      long lowerBound = threadId * batchSize;
      long upperBound = (threadId + 1) * batchSize;
      executorService.submit(new Worker(threadId, region, lowerBound, upperBound));
    });
    return executorService;
  }

  private void populateRegion2(Region region1, Region region2) throws InterruptedException {
    System.out.println("Populate region " + region1.getName() + " and region " + region2.getName());

    ExecutorService executorService1 = startWorkers(region1);
    ExecutorService executorService2 = startWorkers(region2);

    executorService1.shutdown();
    executorService2.shutdown();

    boolean terminated =  executorService1.awaitTermination(Long.MAX_VALUE, TimeUnit.NANOSECONDS);
    if (!terminated) {
      System.out.println("Warning: executorService1 timeout elapsed before termination.");
    }

    terminated =  executorService2.awaitTermination(Long.MAX_VALUE, TimeUnit.NANOSECONDS);
    if (!terminated) {
      System.out.println("Warning: executorService2 timeout elapsed before termination.");
    }
  }

  private void doTest() throws InterruptedException {
    ClientCacheFactory clientCacheFactory = new ClientCacheFactory();
    ClientCache clientCache = clientCacheFactory.addPoolLocator(LOCATOR, LOCATOR_PORT).create();
    Region clientRegion = clientCache.createClientRegionFactory(ClientRegionShortcut.PROXY).create(REGION_NAME);
    populateRegion(clientRegion);
  }

  private void doTest2() throws InterruptedException {
    ClientCacheFactory clientCacheFactory = new ClientCacheFactory();
    ClientCache clientCache = clientCacheFactory.addPoolLocator(LOCATOR, LOCATOR_PORT).create();
    Region clientRegion1 = clientCache.createClientRegionFactory(ClientRegionShortcut.PROXY).create(REGION_NAME_1);
    Region clientRegion2 = clientCache.createClientRegionFactory(ClientRegionShortcut.PROXY).create(REGION_NAME_2);
    populateRegion2(clientRegion1, clientRegion2);
  }

  public static void main(String args[]) throws InterruptedException {
    GeodeClient geodeClient = new GeodeClient();
    geodeClient.doTest2();
  }
}
